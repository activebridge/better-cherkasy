class CommentsController < ApplicationController
  before_action :authorize_user!
  before_action :find_event
  before_action :find_parent, only: :create

  def index
    render json: @event.comments, status: :ok
  end

  def create
    comments = @event.comments
    comment = comments.create(user: current_user, body: params[:body])
    comment.move_to_child_of(@parent) if @parent
    index = comments.index(comment) - 1
    render json: {index: index, data: CommentSerializer.new(comment) }, status: :created
  end

  def destroy
    comment = @event.comments.find(params[:id])
    comment.destroy
    head(:ok)
  end

  private

  def find_event
    @event = Event.find params[:event_id]
  end

  def find_parent
    @parent = @event.comments.find_by_id(params[:parent_id])
  end
end
