class Game < ApplicationRecord
	has_many :pieces

	scope :available, -> { where("white_player_id IS NULL or black_player_id IS NULL")}

	def populate_white_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 1, player_id: self.white_player_id)
		end
	end

end
