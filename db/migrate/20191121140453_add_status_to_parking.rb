class AddStatusToParking < ActiveRecord::Migration[5.2]
  def change
    add_column :parkings, :status, :bool, default: nil
  end
end
