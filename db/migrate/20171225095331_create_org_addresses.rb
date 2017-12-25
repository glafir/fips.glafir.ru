class CreateOrgAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :org_addresses do |t|
      t.integer :org_id
      t.string :address

      t.timestamps
    end
  end
end
