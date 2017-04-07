class CreateBioPush < ActiveRecord::Migration[5.0]
  def change
    create_table :bio_pushes do |t|
      t.string :request_id
      t.datetime :confirmed_at
      t.timestamps
    end
  end
end
