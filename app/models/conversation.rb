# conversation model
class Conversation < ActiveRecord::Base
  validates_presence_of :user_id, :subject

  extend FriendlyId
  friendly_id :subject, use: :slugged

  def should_generate_new_friendly_id?
    subject_changed?
  end

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  belongs_to :friendship

  has_many :participations, -> { order 'id ASC' }, dependent: :destroy
  has_many :participants, through: :participations, source: :user
  has_many :engaged_participations, through: :comments, source: :participation

  has_many :comments

  def my_participation(current_user_id)
    Participation.find_by(user_id: current_user_id, conversation_id: id)
  end

  def ordered_participants
    names = []
    participations.each do |p|
      names << p.user.first_name
    end
    names
  end
end
