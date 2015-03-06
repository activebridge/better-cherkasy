require 'oauth'

class UsersController < ApplicationController
  def create
    oauth = OAuth.call(user_params)
    if oauth.result[:status] == :ok
      render json: oauth.result, status: :ok
    else
      render json: {status: 'fail', message: 'Щось не гаразд. Система не змогла залогінити юзера'},
        status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :avatar_url, :provider, :providerid)
  end
end
