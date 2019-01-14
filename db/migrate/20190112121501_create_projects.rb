class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :date_created
      t.string :status
      t.integer :user_id
      t.integer :project_type_id
    end
  end
end
