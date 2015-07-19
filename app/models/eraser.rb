class Eraser < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :twitter_name, presence: true
  validates :twitter_id, presence: true, uniqueness: { scope: [:user_id] }

  before_validation :fill_twitter_id

  protected

  def fill_twitter_id
    self[:twitter_id] = user.twitter.user(twitter_name).id unless twitter_id
  rescue Twitter::Error::NotFound
    self[:twitter_id] = nil
  end
end
