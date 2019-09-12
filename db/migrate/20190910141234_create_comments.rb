class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :message
      t.references :from_user_id, references: :users
      t.references :to_user_id, references: :users
      t.float :rating
      t.belongs_to :garage
      t.timestamps
    end
  end
end
