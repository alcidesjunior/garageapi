class AddNeighborhoodToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :neighborhood, :string, default: nil
  end
end
