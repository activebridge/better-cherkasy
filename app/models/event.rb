class Event < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_commentable
  acts_as_votable
  geocoded_by :address, latitude: :lat, longitude: :lng

  belongs_to :user
  has_many :subscriptions
  has_many :comments, as: :commentable
  has_many :photos

  scope :primary, -> { order('cached_weighted_score desc') }
  scope :newest, -> { order('created_at desc') }
  scope :most_active, -> { order('comments_count desc').where('comments_count > 0') }
  scope :most_popular, -> { order('cached_weighted_score desc').where('cached_weighted_score > 0') }
  scope :for_last, -> (period) { where('created_at >= ?', Date.today - period) }
  scope :by_location, -> (params) {
    if params[:lat] && params[:lng]
      near([params[:lat], params[:lng]], params[:radius])
    end
  }
  scope :by_tag, -> (tag) {
    if tag
      tagged_with(tag)
    end
  }

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
end
