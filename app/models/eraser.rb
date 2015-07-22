class Eraser < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :twitter_name, presence: true
  validates :twitter_id, presence: true, uniqueness: { scope: [:user_id] }

  before_validation :fill_twitter_id

  def twitter_user=(user)
    @twitter_user = user
    self[:twitter_id] = user.id
    self[:twitter_name] = user.screen_name
  end

  def as_json(opts = nil)
    @twitter_user.as_json(opts)
  end

  protected

  def fill_twitter_id
    self[:twitter_id] = user.twitter.user(twitter_name).id unless twitter_id
  rescue Twitter::Error::NotFound
    self[:twitter_id] = nil
  end
end
