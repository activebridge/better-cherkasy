class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  scope :liked, -> { where(liked: true) }
  scope :disliked, -> { where(liked: false) }

  def disliked?
    !liked
  end
end
