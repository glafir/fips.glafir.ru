class CreateTzRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :tz_requests do |t|
      t.date :date_start
      t.string :doc
      t.integer :org_id
      t.string :img

      t.timestamps
    end
  end
end
