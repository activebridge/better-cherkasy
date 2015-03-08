class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_users

  def likes
    @likes_count ||= event_users.liked.count
  end

  def dislikes
    @dislikes_count ||= event_users.disliked.count
  end

  def rating
    likes - dislikes
  end
end
