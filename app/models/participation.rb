# participation model
class Participation < ActiveRecord::Base
  validates_presence_of :user_id, :conversation_id

  belongs_to :user
  belongs_to :conversation
  has_many :comments, dependent: :destroy

  scope :read, -> { where(read: true) }
  scope :important, -> { where(important: true) }

  def read?
    read
  end

  def important?
    important
  end
end
