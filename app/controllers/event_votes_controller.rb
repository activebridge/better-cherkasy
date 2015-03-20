class EventVotesController < ApplicationController
  before_action :authorize_user!
  before_action :find_event

  def update
    @event.vote_by voter: current_user, vote: params[:vote]
    render json: @event, status: :ok
  end

  private

  def find_event
    @event ||= Event.find(params[:id])
  end
end
