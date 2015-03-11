class TagsController < ApplicationController
  def index
    tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{ params[:query] }%")
    render json: tags, status: :ok
  end
end
