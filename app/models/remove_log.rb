class RemoveLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :eraser, class_name: 'User'

  validates :user, presence: true
  validates :eraser, presence: true
end
