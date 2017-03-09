class CreateTimeCardAndTimeEntry < ActiveRecord::Migration[5.0]
  def change
    create_table :timecards do |t|
      t.string :username
      t.integer :total_hours
      t.date :occurence
    end
    create_table :time_entries do |t|
      t.datetime :time
      t.references :timecard
    end
  end
end
