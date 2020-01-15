class AddColumnPositionToHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :position, :integer, default: 0
  end
end
