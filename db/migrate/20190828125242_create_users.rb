class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role, null: false, default: 'user'
      # t.date :last_login
      t.timestamps
    end
  end
end
