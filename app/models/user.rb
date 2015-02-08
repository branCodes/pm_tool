class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :projects, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :nullify, through: :comments
  has_many :comments, dependent: :nullify


  has_many :memberships, dependent: :destroy
  # has_many :ownerships, class_name: 'Membership', conditions: {type: 'owner'}
  has_many :projects, through: :memberships
  # has_many :owned_projects, through: :ownerships

  has_many :favourites, dependent: :destroy
  has_many :favourited_projects, through: :favourites, source: :question

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".squeeze(" ").strip
    else
      email
    end
  end

  def favourite_for(project)
    favourites.where(project: project).first
  end
end
