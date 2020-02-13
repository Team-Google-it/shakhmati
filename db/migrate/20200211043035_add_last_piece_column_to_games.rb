class AddLastPieceColumnToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :last_piece, :integer, array: true, default: []
  end
end
