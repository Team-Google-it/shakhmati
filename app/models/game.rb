class Game < ApplicationRecord
	after_create :populate_white_pieces, :populate_black_pieces

	has_many :pieces

	scope :available, -> { where("white_player_id IS NULL or black_player_id IS NULL")}

	def in_check?(color)
		king = get_piece('King', color)
		opponent_pieces(color).each do |opponent|
			return true if opponent.valid_move?(king.x_position, king.y_position)
		end
		false
	end

	def populate_white_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 1, player_id: self.white_player_id, color: "white")
		end
		Rook.create(game_id: self.id, x_position: 0, y_position: 0, player_id: self.white_player_id, color: "white")
		Rook.create(game_id: self.id, x_position: 7, y_position: 0, player_id: self.white_player_id, color: "white")

		Knight.create(game_id: self.id, x_position: 1, y_position: 0, player_id: self.white_player_id, color: "white")
		Knight.create(game_id: self.id, x_position: 6, y_position: 0, player_id: self.white_player_id, color: "white")

		Bishop.create(game_id: self.id, x_position: 2, y_position: 0, player_id: self.white_player_id, color: "white")
		Bishop.create(game_id: self.id, x_position: 5, y_position: 0, player_id: self.white_player_id, color: "white")

		Queen.create(game_id: self.id, x_position: 3, y_position: 0, player_id: self.white_player_id, color: "white")
		King.create(game_id: self.id, x_position: 4, y_position: 0, player_id: self.white_player_id, color: "white")
	end

	def populate_black_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 6, player_id: self.black_player_id, color: "black")
		end
		Rook.create(game_id: self.id, x_position: 0, y_position: 7, player_id: self.black_player_id, color: "black")
		Rook.create(game_id: self.id, x_position: 7, y_position: 7, player_id: self.black_player_id, color: "black")

		Knight.create(game_id: self.id, x_position: 1, y_position: 7, player_id: self.black_player_id, color: "black")
		Knight.create(game_id: self.id, x_position: 6, y_position: 7, player_id: self.black_player_id, color: "black")

		Bishop.create(game_id: self.id, x_position: 2, y_position: 7, player_id: self.black_player_id, color: "black")
		Bishop.create(game_id: self.id, x_position: 5, y_position: 7, player_id: self.black_player_id, color: "black")

		Queen.create(game_id: self.id, x_position: 3, y_position: 7, player_id: self.black_player_id, color: "black")
		King.create(game_id: self.id, x_position: 4, y_position: 7, player_id: self.black_player_id, color: "black")
	end

	def get_piece(type, color)
		pieces.where(type: type, color: color).first
	end

	def opponent_color(color)
		color == "white" ? "black" : "white"
	end

	def opponent_pieces(color)
		pieces_where(color: opponent_color(color))
	end

end
