class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :content
      t.integer :user_id
      t.integer :project_type_id
    end
  end
end
