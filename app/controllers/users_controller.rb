require 'oauth'

class UsersController < ApplicationController
  def create
    oauth = OAuth.call(user_params)
    if oauth.status == :success
      render json: {status: 'OK'}.merge(oauth.result), status: :ok
    else
      render json: {status: 'FAIL', message: 'Щось не гаразд. Система не змогла залогінити юзера'},
        status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :avatar_url, :provider, :providerid, :token)
  end
end
