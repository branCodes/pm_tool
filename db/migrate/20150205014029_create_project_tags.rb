class CreateProjectTags < ActiveRecord::Migration
  def change
    create_table :project_tags do |t|
      t.references :tag, index: true
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :project_tags, :tags
    add_foreign_key :project_tags, :projects
  end
end
