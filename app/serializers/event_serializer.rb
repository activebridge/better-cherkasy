class EventSerializer < ActiveModel::Serializer
  attributes :id, :headline, :description, :rating, :creator, :date, :time

  def creator
    UserSerializer.new(object.user)
  end
end
