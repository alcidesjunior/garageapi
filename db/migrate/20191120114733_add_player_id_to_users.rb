class AddPlayerIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :player_id, :integer, default: nil
  end
end
