class ApplicationController < ActionController::Base

  def current_user
    @user ||= User.find_by_auth_token(session[:token])
  end

  helper_method :current_user
end
