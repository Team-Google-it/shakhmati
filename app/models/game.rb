class Game < ApplicationRecord
	after_create :populate_white_pieces, :populate_black_pieces

	has_many :pieces

	scope :available, -> { where("white_player_id IS NULL or black_player_id IS NULL")}

	def populate_white_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 1, player_id: self.white_player_id)
		end
		Rook.create(game_id: self.id, x_position: 0, y_position: 0, player_id: self.white_player_id)
		Rook.create(game_id: self.id, x_position: 7, y_position: 0, player_id: self.white_player_id)

		Knight.create(game_id: self.id, x_position: 1, y_position: 0, player_id: self.white_player_id)
		Knight.create(game_id: self.id, x_position: 6, y_position: 0, player_id: self.white_player_id)

		Bishop.create(game_id: self.id, x_position: 2, y_position: 0, player_id: self.white_player_id)
		Bishop.create(game_id: self.id, x_position: 5, y_position: 0, player_id: self.white_player_id)

		Queen.create(game_id: self.id, x_position: 3, y_position: 0, player_id: self.white_player_id)
		King.create(game_id: self.id, x_position: 4, y_position: 0, player_id: self.white_player_id)
	end

	def populate_black_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 6, player_id: self.black_player_id)
		end
		Rook.create(game_id: self.id, x_position: 0, y_position: 7, player_id: self.black_player_id)
		Rook.create(game_id: self.id, x_position: 7, y_position: 7, player_id: self.black_player_id)

		Knight.create(game_id: self.id, x_position: 1, y_position: 7, player_id: self.black_player_id)
		Knight.create(game_id: self.id, x_position: 6, y_position: 7, player_id: self.black_player_id)

		Bishop.create(game_id: self.id, x_position: 2, y_position: 7, player_id: self.black_player_id)
		Bishop.create(game_id: self.id, x_position: 5, y_position: 7, player_id: self.black_player_id)

		Queen.create(game_id: self.id, x_position: 3, y_position: 7, player_id: self.black_player_id)
		King.create(game_id: self.id, x_position: 4, y_position: 7, player_id: self.black_player_id)
	end

end
