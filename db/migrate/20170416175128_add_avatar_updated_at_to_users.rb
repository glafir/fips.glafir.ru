class AddAvatarUpdatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_updated_at, :datetime
  end
end
