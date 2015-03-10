class SubscriptionsController < ApplicationController
  before_action :authorize_user!
  before_action :find_subscription, only: :destroy

  def create
    @subscription = Subscription.new(subscription_params)
    current_user.subscriptions << @subscription
    render json: @subscription, status: :created
  end

  def destroy
    @subscription.destroy if @subscription
    head(:accepted)
  end

  private

  def subscription_params
    params.require(:subscription).permit!
  end

  def find_subscription
    @subscription ||= Subscription.find_by_id(params[:id])
  end
end
