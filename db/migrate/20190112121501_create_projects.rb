class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :models
      t.integer :user_id
      t.integer :project_type_id
    end
  end
end
