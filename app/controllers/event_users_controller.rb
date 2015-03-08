class EventUsersController < ApplicationController
  before_action :authorize_user!
  before_action :find_event

  def update
    existing_like = @event.event_users.find_by_user_id(current_user.id)
    if existing_like
      undo_like = existing_like.liked? && !params[:like]
      undo_dislike = existing_like.disliked? && params[:like]
      existing_like.update_attribute(:liked, !existing_like.liked) if undo_like || undo_dislike
      render json: @event, status: :ok
    else
      like = @event.event_users.create(user: current_user, liked: params[:like])
      render json: @event, status: :ok
    end
  end

  private

  def find_event
    @event ||= Event.find(params[:id])
  end
end
