class PhotosController < ApplicationController
  before_action :authorize_user!
  before_action :find_own_event, only: [ :create ]

  def create
    photo = @event.photos.create(image: params[:file])
    render json: photo, status: :created
  end

  private

  def find_own_event
    @event = current_user.events.find(params[:event_id])
  end

end
