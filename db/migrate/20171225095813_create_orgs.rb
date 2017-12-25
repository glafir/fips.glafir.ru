class CreateOrgs < ActiveRecord::Migration[5.0]
  def change
    create_table :orgs do |t|
      t.string :shortname
      t.string :fullname
      t.date :create
      t.integer :org_state_id

      t.timestamps
    end
  end
end
