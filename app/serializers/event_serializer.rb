class EventSerializer < BasicEventSerializer
  attributes :likes, :dislikes, :creator, :comments_count, :rating, :created_at

  has_many :subscriptions

  def creator
    UserSerializer.new(object.user)
  end

  def comments_count
    object.comments.count
  end

  def created_at
    object.created_at.strftime('%H:%M %d.%m')
  end
end
