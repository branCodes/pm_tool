class AddProjectReferencesToDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :project, index: true
    add_foreign_key :discussions, :projects
  end
end
