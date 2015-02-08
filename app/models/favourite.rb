class Favourite < ActiveRecord::Base
  validates :user_id, uniqueness: {scope: :project_id}

  belongs_to :project
  belongs_to :user
end
