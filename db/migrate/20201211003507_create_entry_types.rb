class CreateEntryTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :entry_types do |t|
      t.string :code
      t.string :description
    end
  end
end
