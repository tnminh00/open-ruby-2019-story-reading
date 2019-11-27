class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :name
      t.integer :story_id
      t.string :content

      t.timestamps
    end
  end
end
