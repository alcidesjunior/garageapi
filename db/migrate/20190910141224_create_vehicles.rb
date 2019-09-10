class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :chassi
      t.string :license_plate
      t.string :year
      t.string :driver_license
      
      t.belongs_to :user
      t.timestamps
    end
  end
end
