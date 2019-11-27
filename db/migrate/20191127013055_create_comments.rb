class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.belongs_to :commentable, polymorphic: true
      t.string :content

      t.timestamps
    end
  end
end
