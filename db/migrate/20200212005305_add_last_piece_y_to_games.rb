class AddLastPieceYToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :last_piece_y, :integer
  end
end
