class CreateFipsTzs < ActiveRecord::Migration
  def change
    create_table :fips_tzs do |t|
      t.integer :tz_n
      t.string :url_string_fips
      t.string :doc

      t.timestamps
    end
  end
end
