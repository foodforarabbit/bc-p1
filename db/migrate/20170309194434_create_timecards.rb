class CreateTimecards < ActiveRecord::Migration[5.0]
  def change
    create_table :timecards do |t|
      t.string :username
      t.date :occurrence
      t.float :total_hours
      t.integer :time_entries_count
      t.timestamps
    end
  end
end
