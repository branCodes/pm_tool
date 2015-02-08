class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :favourites, :projects
    add_foreign_key :favourites, :users
  end
end
