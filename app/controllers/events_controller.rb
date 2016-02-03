class EventsController < ApplicationController
  before_action :authorize_user!, except: [ :index, :show ]
  before_action :find_own_event, only: [ :destroy, :update, :edit ]
  before_action :find_event, only: :show
  after_action :track_visits, only: :show

  wrap_parameters :event, include: [:headline, :description,
                                    :date, :time, :tags,
                                    :lat, :lng, :address]

  def index
    if params[:service]
      service_class = params[:service].constantize
      @events = service_class.new(params).fetch
      serializer = service_class.serializer
    else
      @events = Event.primary.send(params[:scope] || Event::STATUS[:pending])
      serializer = EventSerializer
    end
    json = ActiveModel::ArraySerializer.new(@events,
                                           each_serializer: serializer,
                                           root: nil)
    render json: json, status: :ok
  end

  def mine
    events = current_user.events
                         .order('cached_weighted_score desc')
                         .send(params[:scope] || Event::STATUS[:pending])
    json = ActiveModel::ArraySerializer.new(events,
                                           each_serializer: EventSerializer,
                                           root: nil)
    render json: json, status: :ok
  end

  def subscriptions
    events = current_user.subscribed_events
                         .order('cached_weighted_score desc')
                         .send(params[:scope] || Event::STATUS[:pending])
    json = ActiveModel::ArraySerializer.new(events,
                                           each_serializer: EventSerializer,
                                           root: nil)
    render json: json, status: :ok
  end

  def edit
    render json: BasicEventSerializer.new(@event), status: :ok
  end

  def show
    render json: FullEventSerializer.new(@event), status: :ok
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      render json: @event, status: :created
    else
      render json: { status: :error, error: @event.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head(:ok)
  end

  def update
    if @event.update_attributes(event_params)
      render json: @event, status: :accepted
    else
      render json: { status: :error, error: @event.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params[:event].merge!(time: params[:date])
    params.require(:event).permit([:headline, :description,
                                    :date, :time,
                                    :lat, :lng, :address, :completed,
                                    tags: [:name]
    ])
  end

  def find_event
    @event = Event.find_by_id(params[:id])
  end

  def find_own_event
    @event = current_user.events.find(params[:id])
  end

  def track_visits
    @event.add_visit!
  end
end

