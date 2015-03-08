class User < ActiveRecord::Base
  has_many :event_users
  has_many :events

  validates :name, :avatar_url, :provider, :providerid, presence: true

  def authenticate!
    token = Digest::SHA1.hexdigest([Time.now, self.id, rand].join)[0..16]
    update_attribute(:auth_token, token)
    token
  end
end
