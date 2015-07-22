class User < ActiveRecord::Base
  devise :omniauthable

  has_many :erasers
  has_many :erasable, class_name: 'Eraser', foreign_key: :twitter_id, primary_key: :uid
  has_many :slaves, through: :erasable, source: :user

  validates :uid, presence: true, uniqueness: true
  validates :nick, presence: true
  validates :access_token, presence: true
  validates :secret_token, presence: true

  def self.from_twitter(auth)
    user = find_by(uid: auth.uid) || User.new(uid: auth.uid.to_s)
    user.update(nick: auth.info.nickname,
                access_token: auth.credentials.token,
                secret_token: auth.credentials.secret)
    user
  end

  def me
    cache.user(uid.to_i)
  end

  def eraser_uids
    erasers.map { |eraser| eraser.twitter_id.to_i }
  end

  def bosses
    cache.users(eraser_uids)
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

  def twitter
    @twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = access_token
      config.access_token_secret = secret_token
    end
  end

  protected

  def cache
    @cache ||= Twitter::Cache.new(twitter)
  end
end
