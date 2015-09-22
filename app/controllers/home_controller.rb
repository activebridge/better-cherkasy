class HomeController < ApplicationController
  def index
    gon.vk_client_id = Rails.application.secrets.vk_key
  end
end
