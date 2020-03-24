class AddDeviseToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password_digest, :encrypted_password
    rename_column :users, :remember_digest, :remember_created_at
    change_column :users, :remember_created_at, :datetime

    add_index :users, :email, unique: true
  end
end
