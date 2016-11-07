# user model
# rubocop:disable Metrics/LineLength
class User < ActiveRecord::Base
  validates_presence_of :name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :conversations, dependent: :destroy

  has_many :participations, dependent: :destroy
  has_many :participated_conversations, through: :participations, source: :conversation

  def first_name
    name.split(' ').first
  end

  # def initials
  #   splitname = name.split(' ')
  #   if splitname.count == 1
  #     splitname.first.first.upcase + 'x'
  #   else
  #     splitname.first.first.upcase + splitname[1].first.upcase
  #   end
  # end

  def participations_ordered_by_comments
    Participation.where(user_id: id).includes(:comments).order('comments.created_at desc')
  end

  def all_friendships
    (friendships + inverse_friendships).sort_by(&:updated_at)
  end

  def all_active_friendships
    all_friendships = (friendships + inverse_friendships).sort_by(&:updated_at)
    all_friendships.select { |f| f.status == 'active' }
  end
end
