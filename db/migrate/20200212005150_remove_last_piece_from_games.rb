class RemoveLastPieceFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :last_piece, :integer
  end
end
