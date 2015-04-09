class Region < ActiveRecord::Base
  validates :title, presence: true
end
