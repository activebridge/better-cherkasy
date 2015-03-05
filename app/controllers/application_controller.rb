class ApplicationController < ActionController::Base

  def current_user
    @user ||= User.authenticate_by_access_token(session[:token])
  end

  helper_method :current_user
end
