class EventsController < ApplicationController
  before_action :find_event, only: [:destroy, :update]

  def index
    json = ActiveModel::ArraySerializer.new(Event.order('rating desc'),
                                           each_serializer: EventSerializer,
                                           root: nil)
    render json: json, status: 200
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: EventSerializer.new(event), status: 200
    else
      render json: {status: :error, error: event.errors.messages}, status: 422
    end
  end

  def destroy
    @event.destroy
    head(200)
  end

  def update
    if @event.update_attributes(event_params)
      render json: EventSerializer.new(@event), status: 201
    else
      render json: {status: :error, error: @event.errors.messages}, status: 422
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

