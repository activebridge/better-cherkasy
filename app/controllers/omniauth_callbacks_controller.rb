require 'oauth'
class OmniauthCallbacksController < ApplicationController
  layout false

  def odnoklassniki
    user_info = request.env['omniauth.auth']
    if user_info
      @oauth = OAuth.call(provider: user_info.provider,
                        providerid: user_info.uid,
                              name: user_info.info.name,
                        avatar_url: user_info.info.image)
    end
  end
end
