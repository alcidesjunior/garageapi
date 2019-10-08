class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :document_type, null: false, default: 'cpf'
      t.string :document_number
      t.string :password_digest
      t.string :role, null: false, default: 'ROLE_GD'
      #ROLE_GD: garage driver
      #ROLE_GO: garage owner
      t.boolean :isActive, default: true
      t.timestamps
    end
  end
end
