# friendship model
class Friendship < ActiveRecord::Base
  validates_presence_of :user_id, :friend_id, :status

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  def pending
    status == 'pending' ? true : false
  end

  def get_friend(current_user)
    friend.id == current_user.id ? user : friend
  end
end
