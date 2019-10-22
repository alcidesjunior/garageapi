class CreateGarages < ActiveRecord::Migration[5.2]
  def change
    create_table :garages do |t|
      t.string :description
      t.integer :parking_spaces
      t.integer :busy_space, default: 0
      t.float :price
      t.text :photo1
      t.text :photo2
      t.text :photo3

      t.belongs_to :user
      t.timestamps
    end
  end
end
