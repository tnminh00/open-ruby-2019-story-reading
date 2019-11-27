class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name
      t.string :author
      t.string :introduction
      t.integer :total_view, default: 0

      t.timestamps
    end
  end
end
