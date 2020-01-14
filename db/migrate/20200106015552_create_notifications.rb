class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :event
      t.integer :user_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
