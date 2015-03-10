class EventSerializer < ActiveModel::Serializer
  attributes :id, :headline, :description, :rating,
    :creator, :date, :time

  has_many :subscriptions

  def creator
    UserSerializer.new(object.user)
  end

  def date
    object.date.strftime('%d-%m-%Y') if object.date
  end

  def time
    object.time.strftime('%I:%M %p') if object.time
  end
end
