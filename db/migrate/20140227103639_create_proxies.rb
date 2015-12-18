class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.string :proxy_address
      t.string :proxy_port
      t.integer :proxy_status
      t.float :proxy_timeout

      t.timestamps
    end
  end
end
