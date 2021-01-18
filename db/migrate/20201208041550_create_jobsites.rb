class CreateJobsites < ActiveRecord::Migration[6.1]
  def change
    create_table :jobsites do |t|
      t.string :name
    end
  end
end
