class Eraser < ActiveRecord::Base
  validates :user, presence: true
  validates :twitter_name, presence: true
  validates :twitter_id, presence: true, uniqueness: {scope: [:user_id]}

  belongs_to :user
end
