class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  after_save :update_event_rating
  after_destroy :update_event_rating

  scope :liked, -> { where(liked: true) }
  scope :disliked, -> { where(liked: false) }

  def disliked?
    !liked
  end

  private

  def update_event_rating
    event.update_attribute(:rating, event.likes - event.dislikes)
  end
end
