class User < ActiveRecord::Base
  devise :omniauthable

  has_many :erasers
  has_many :slaves, class_name: 'Eraser', foreign_key: :twitter_id, primary_key: :uid

  def self.from_twitter(auth)
    where(auth.slice(:uid)).first_or_create do |user|
      user.uid = auth.uid
      user.nick = auth.info.screen_name
      user.access_token = auth.credentials.token
      user.secret_token = auth.credentials.secret
    end
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = access_token
      config.access_token_secret = secret_token
    end
  end
end
