class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :code, :limit => 3
      t.string :name
      t.integer :jobsite_id
    end
  end
end
