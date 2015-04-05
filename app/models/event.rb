class Event < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_commentable
  acts_as_votable

  belongs_to :user
  has_and_belongs_to_many :regions
  has_many :subscriptions
  has_many :comments, as: :commentable

  def add_comment(user, text)
    comments.create(user: user, body: text)
  end

  validates :headline, :description, presence: true

  def likes
    cached_votes_up
  end

  def dislikes
    cached_votes_down
  end

  def rating
    cached_weighted_average
  end

  def tags=(data)
    return unless data
    super data.map{ |item| ActsAsTaggableOn::Tag.find_or_create_by(item) }
  end

  def regions=(data)
    return unless data
    regions = data.map { |title| Region.find_or_create_by(title: title) }.compact
    super regions if regions.present?
  end
end
