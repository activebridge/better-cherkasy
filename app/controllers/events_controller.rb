class EventsController < ApplicationController
  before_action :find_event, only: [:destroy, :update]

  def index
    json = ActiveModel::ArraySerializer.new(Event.order('rating desc'),
                                           each_serializer: EventSerializer,
                                           root: nil)
    render json: json, status: :ok
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: EventSerializer.new(event), status: :ok
    else
      render json: {status: :error, error: event.errors.messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head(:ok)
  end

  def update
    if @event.update_attributes(event_params)
      render json: EventSerializer.new(@event), status: :created
    else
      render json: {status: :error, error: @event.errors.messages}, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit!
  end

  def find_event
    @event = Event.find(params[:id])
  end
end

