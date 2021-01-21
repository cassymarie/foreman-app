class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :job_number
      t.string :name
      t.string :customer
      t.integer :jobsite_id
      t.boolean :active, default: true
    end
  end
end
