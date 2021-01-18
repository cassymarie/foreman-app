class CreateUserJobsites < ActiveRecord::Migration[6.1]
  def change
    create_table :user_jobsites do |t|
      t.integer :user_id
      t.integer :jobsite_id
    end
  end
end
