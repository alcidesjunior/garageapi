class AddIsActiveColumnToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :isActive, :boolean, default: true
  end
end
