class CreateTimeEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :time_entries do |t|
      t.datetime :workdate
      t.integer :jobsite_id
      t.integer :employee_id
      t.integer :job_id
      t.integer :area_id
      t.integer :task_id
      t.decimal :hours
      t.integer :entry_id
      t.timestamps null: false
    end
  end
end

