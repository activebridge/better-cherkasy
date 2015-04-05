class Region < ActiveRecord::Base
  has_and_belongs_to_many :events

  validates :title, presence: true
end
