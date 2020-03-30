class AddTypeToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :sales_type, :integer, default: 0
  end
end
