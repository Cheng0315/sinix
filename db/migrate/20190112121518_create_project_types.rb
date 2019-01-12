class CreateProjectTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :project_types do |t|
      t.string :name
    end
  end
end
