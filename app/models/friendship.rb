# friendship model
class Friendship < ActiveRecord::Base
  validates_presence_of :user_id, :friend_id, :status

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
