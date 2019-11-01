class AddAvatarToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :text, default: nil
  end
end
