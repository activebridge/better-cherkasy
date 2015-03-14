class Event < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_commentable

  belongs_to :user
  has_many :event_users
  has_many :subscriptions
  has_many :comments, as: :commentable

  def add_comment(user, text)
    comments.create(user: user, body: text)
  end

  validates :headline, :description, presence: true

  def likes
    event_users.liked.count
  end

  def dislikes
    event_users.disliked.count
  end

  def tags=(data)
    return unless data
    super data.map{ |item| ActsAsTaggableOn::Tag.find_or_create_by(item) }
  end
end
