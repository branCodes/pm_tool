class Project < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :nullify
  
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :project_tags, dependent: :destroy
  has_many :tags, through: :project_tags

  has_many :favourites, dependent: :destroy
  has_many :favourited_users, through: :favourites, source: :user
  
  def self.search(query)
    where("title ilike ?", "%#{query}%") 
    where("description ilike ?", "%#{query}%") 
  end
end



# Project: title(required & unique), description and due_date
# Task: title (required & unique within a project) and due_date
# Discussion: title(required), description
# Comment: body(required)