class RemoveLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :eraser, class_name: 'User'
end
