class AddIndexToPieces < ActiveRecord::Migration[5.2]
  def change
    add_index :pieces, :x_position
    add_index :pieces, :y_position
  end
end
