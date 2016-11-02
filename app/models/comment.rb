# comment class
class Comment < ActiveRecord::Base
  validates_presence_of :participation_id, :conversation_id, :content

  belongs_to :participation
  belongs_to :conversation

  has_one :commenter, through: :participation, source: :user
end
