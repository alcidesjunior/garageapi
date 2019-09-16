class CreateGarages < ActiveRecord::Migration[5.2]
  def change
    create_table :garages do |t|
      t.string :description
      t.integer :parking_spaces
      t.float :price
      t.string :photo1
      t.string :photo2
      t.string :photo3

      t.belongs_to :user
      # t.belongs_to :address
      t.timestamps
    end
  end
end
