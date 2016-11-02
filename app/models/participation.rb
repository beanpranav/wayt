# participation model
class Participation < ActiveRecord::Base
  validates_presence_of :user_id, :conversation_id

  belongs_to :user
  belongs_to :conversation
  has_many :comments, dependent: :destroy

  scope :unread, -> { where(read: false) }
  scope :important, -> { where(important: true) }

  def unread?
    !read
  end

  def important?
    important
  end
end
