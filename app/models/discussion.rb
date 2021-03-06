class Discussion < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :project
  belongs_to :user
  has_many :comments, dependent: :destroy
end

# Project: title(required & unique), description and due_date
# Task: title (required & unique within a project) and due_date
# Discussion: title(required), description
# Comment: body(required)