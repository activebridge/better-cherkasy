class SessionsController < ApplicationController

  def show
    if user = User.find_by_auth_token(params[:id])
      render json: user, status: :ok
    else
      head(:unauthorized)
    end
  end
end
