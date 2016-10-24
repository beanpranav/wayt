# rubocop:disable Metrics/LineLength
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def first_name
    name.split(' ').first
  end

  def initials
    splitname = name.split(' ')
    if splitname.count == 1
      splitname.first.first.upcase + 'x'
    else
      splitname.first.first.upcase + splitname[1].first.upcase
    end
  end
end
