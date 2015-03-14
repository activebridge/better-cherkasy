class CommentsController < ApplicationController
  before_action :authorize_user!
  before_action :find_event

  def index
    render json: @event.comments, status: :ok
  end

  def create
    comment = @event.comments.create(user: current_user, body: params[:text])
    render json: comment, status: :created
  end

  private

  def find_event
    @event = Event.find params[:event_id]
  end
end
