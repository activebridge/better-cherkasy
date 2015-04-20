class EventSerializer < BasicEventSerializer
  attributes :likes, :dislikes, :creator, :comments_count, :rating, :created_at

  has_many :subscriptions
  has_many :photos

  def creator
    UserSerializer.new(object.user)
  end

  def created_at
    object.created_at.strftime('%H:%M %d.%m')
  end
end
