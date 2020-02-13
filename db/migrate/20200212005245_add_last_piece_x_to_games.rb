class AddLastPieceXToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :last_piece_x, :integer
  end
end
