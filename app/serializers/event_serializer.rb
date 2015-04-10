class EventSerializer < BasicEventSerializer
  attributes :likes, :dislikes, :creator, :comments_count, :rating

  has_many :subscriptions

  def creator
    UserSerializer.new(object.user)
  end

  def comments_count
    object.comments.count
  end
end
