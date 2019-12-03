class ChangeContentFromChapter < ActiveRecord::Migration[5.2]
  def change
    change_column :chapters, :content, :text
  end
end
