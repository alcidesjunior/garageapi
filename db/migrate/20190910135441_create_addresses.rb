class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :zip
      t.string :street
      t.string :number
      t.string :complement
      t.string :city
      t.string :uf
      t.decimal :lat, default: 0.0
      t.decimal :long, default: 0.0

      t.belongs_to :user
      t.belongs_to :garage
      t.timestamps
    end
  end
end
