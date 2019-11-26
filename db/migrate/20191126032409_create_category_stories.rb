class CreateCategoryStories < ActiveRecord::Migration[5.2]
  def change
    create_table :category_stories do |t|
      t.integer :category_id
      t.integer :story_id

      t.timestamps
    end
  end
end
