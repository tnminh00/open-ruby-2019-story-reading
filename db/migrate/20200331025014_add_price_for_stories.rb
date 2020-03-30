class AddPriceForStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :price, :float
  end
end
