class AddAvatarFileSizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_file_size, :integer
  end
end
