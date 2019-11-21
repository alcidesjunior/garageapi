class ChangePlayerIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |table|
    table.change :player_id, :text
  end
  end
end
