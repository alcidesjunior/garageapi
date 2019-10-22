class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :title, default: ""
      t.string :message, default: ""
      t.references :from_user, references: :users
      t.references :to_user, references: :users
      t.float :rating
      t.belongs_to :garage
      t.timestamps
    end
  end
end
