class PhotoSerializer < ActiveModel::Serializer
  attributes :thumb, :medium, :origin

  def thumb
    object.image.url(:thumb)
  end

  def medium
    object.image.url(:medium)
  end

  def origin
    object.image.url
  end
end
