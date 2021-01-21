class CreateJobsites < ActiveRecord::Migration[6.1]
  def change
    create_table :jobsites do |t|
      t.string :name
      t.string :city
      t.string :state
      t.boolean :active, :default => true
    end
  end
end
