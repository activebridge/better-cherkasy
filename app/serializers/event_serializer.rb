class EventSerializer < ActiveModel::Serializer
  attributes :id, :headline, :description, :rating,
    :creator, :date, :time, :comments_count

  has_many :subscriptions
  has_many :tags

  def creator
    UserSerializer.new(object.user)
  end

  def date
    object.date.strftime('%d-%m-%Y') if object.date
  end

  def time
    object.time.strftime('%I:%M %p') if object.time
  end

  def comments_count
    object.comments.count
  end
end
