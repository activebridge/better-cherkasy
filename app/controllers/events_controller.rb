class EventsController < ApplicationController
  before_action :authorize_user!, except: :index
  before_action :find_event, only: :destroy

  wrap_parameters :event, include: [:headline, :description,
                                    :date, :time, :tags]

  def index
    json = ActiveModel::ArraySerializer.new(Event.order('rating desc'),
                                           each_serializer: EventSerializer,
                                           root: nil)
    render json: json, status: :ok
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      render json: @event, status: :ok
    else
      render json: { status: :error, error: @event.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head(:ok)
  end

  private

  def event_params
    params.require(:event).permit!
  end

  def find_event
    @event = current_user.events.find(params[:id])
  end
end

