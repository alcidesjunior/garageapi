class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.integer :garage_owner_id, references: :users #associar ao user id
      t.integer :driver_id, references: :users #associar ao user id
      t.float  :price
      t.string :license_plate

      t.belongs_to :user
      t.belongs_to :vehicle
      t.belongs_to :garage

      t.datetime :start
      t.datetime :end
      t.timestamps
    end
  end
end
