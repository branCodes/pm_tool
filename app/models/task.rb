class Task < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :project_id}
  belongs_to :project
  belongs_to :user
end
# Project: title(required & unique), description and due_date
# Task: title (required & unique within a project) and due_date
# Discussion: title(required), description
# Comment: body(required)