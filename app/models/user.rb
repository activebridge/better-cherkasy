class User < ActiveRecord::Base
  has_many :access_tokens

  def self.authenticate_by_access_token token
    access_token = AccessToken.find_by_token(token)
    access_token ? access_token.user : nil
  end

  def authenticate!
    access_tokens.create(token: Digest::SHA1.hexdigest([Time.now, self.id].join)[0..16])
  end
end
