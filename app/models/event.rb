class Event < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_commentable
  acts_as_votable
  geocoded_by :address, latitude: :lat, longitude: :lng

  belongs_to :user
  has_many :subscriptions
  has_many :comments, as: :commentable

  scope :primary, -> { order('cached_weighted_score desc') }
  scope :newest, -> { order('created_at desc') }
  scope :most_active, -> { }
  scope :most_popular, -> { }
  scope :by_location, -> (params) {
    near([params[:lat], params[:lng]], params[:radius])
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
