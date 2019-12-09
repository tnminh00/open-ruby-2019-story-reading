class AddColumnChapterToChapters < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :chapter_number, :integer
  end
end
