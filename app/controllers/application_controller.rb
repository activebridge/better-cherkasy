class ApplicationController < ActionController::Base

  def current_user
    @user ||= User.find_by_auth_token(params[:auth_token])
  end

  helper_method :current_user

  private

  def authorize_user!
    return head(:unauthorized) unless current_user
  end
end
