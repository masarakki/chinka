class User < ActiveRecord::Base
  devise :omniauthable

  has_many :erasers
  has_many :erasable, class_name: 'Eraser', foreign_key: :twitter_id, primary_key: :uid
  has_many :slaves, through: :erasable, source: :user

  def self.from_twitter(auth)
    (where(uid: auth.uid).first || User.new(uid: auth.uid.to_s)).tap do |user|
      user.nick = auth.info.nickname
      user.access_token = auth.credentials.token
      user.secret_token = auth.credentials.secret
      user.save
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

  def to_param
    nick
  end
end
