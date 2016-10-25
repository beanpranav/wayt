# conversation model
class Conversation < ActiveRecord::Base
  validates_presence_of :user_id, :subject

  extend FriendlyId
  friendly_id :subject, use: :slugged

  def should_generate_new_friendly_id?
    subject_changed?
  end

  belongs_to :user
  belongs_to :friendship

  has_many :participations
  has_many :participants, through: :participations, source: :user

  has_many :comments
end
