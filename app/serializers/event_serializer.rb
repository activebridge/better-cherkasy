class EventSerializer < ActiveModel::Serializer
  attributes :id, :headline, :description, :rating, :creator

  def creator
    UserSerializer.new(object.user)
  end
end
