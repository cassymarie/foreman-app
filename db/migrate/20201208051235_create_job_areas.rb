class CreateJobAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :job_areas do |t|
      t.integer :job_id
      t.integer :area_id
    end
  end
end
