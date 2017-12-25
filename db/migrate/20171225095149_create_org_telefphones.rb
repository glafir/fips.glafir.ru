class CreateOrgTelefphones < ActiveRecord::Migration[5.0]
  def change
    create_table :org_telefphones do |t|
      t.integer :org_id
      t.string :telephone

      t.timestamps
    end
  end
end
