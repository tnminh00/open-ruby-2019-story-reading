class ChangeIntroductionFromStories < ActiveRecord::Migration[5.2]
  def change
    change_column :stories, :introduction, :text
  end
end
