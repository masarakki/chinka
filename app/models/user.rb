class User < ActiveRecord::Base
  devise :omniauthable

  def self.from_twitter(auth)
    where(auth.slice(:uid)).first_or_create do |user|
      user.uid = auth.uid
      user.nick = auth.info.name
      user.access_token = auth.credentials.token
      user.secret_token = auth.credentials.secret
    end
  end
end
