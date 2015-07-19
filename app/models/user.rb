class User < ActiveRecord::Base
  devise :omniauthable

  has_many :erasers
  has_many :erasable, class_name: 'Eraser', foreign_key: :twitter_id, primary_key: :uid
  has_many :slaves, through: :erasable, source: :user

  def self.from_twitter(auth)
    user = find_by(uid: auth.uid) || User.new(uid: auth.uid.to_s)
    user.update(nick: auth.info.nickname,
                access_token: auth.credentials.token,
                secret_token: auth.credentials.secret)
    user
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = access_token
      config.access_token_secret = secret_token
    end
  end

  def destroy_tweet(user, id)
    return false unless slaves.include?(user)
    tweet = user.twitter.status(id)
    user.twitter.destroy_tweet(id)
    RemoveLog.create user: user, eraser: self, body: tweet.full_text
  end

  def to_param
    nick
  end
end
