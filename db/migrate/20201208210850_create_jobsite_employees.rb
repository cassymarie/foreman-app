class CreateJobsiteEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :jobsite_employees do |t|
      t.integer :jobsite_id
      t.integer :employee_id
    end
  end
end
