class SessionsController < ApplicationController

  def show
    if user = User.authenticate_by_access_token(params[:id])
      render json: user, status: :ok
    end
  end
end
