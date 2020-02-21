class Game < ApplicationRecord
	after_create :populate_white_pieces, :populate_black_pieces

	has_many :pieces

	scope :available, -> { where("white_player_id IS NULL or black_player_id IS NULL")}
	scope :by_status, ->(status) { where(status: status)}
	scope :in_progress, -> { by_status('in_progress')}

	def in_check?
		status == 'in_check'
	end

	def checkmate?
		status == 'checkmate'
	end

	def assign_first_turn
		update_attributes(turn: 'white')
	end

	def swap_turn
		change = turn == 'white' ? 'black' : 'white'
		update_attributes(turn: change)
	end

	def populate_white_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 1, player_id: self.white_player_id, color: "white", status: "start", captured: false)
		end
		Rook.create(game_id: self.id, x_position: 0, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)
		Rook.create(game_id: self.id, x_position: 7, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)

		Knight.create(game_id: self.id, x_position: 1, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)
		Knight.create(game_id: self.id, x_position: 6, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)

		Bishop.create(game_id: self.id, x_position: 2, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)
		Bishop.create(game_id: self.id, x_position: 5, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)

		Queen.create(game_id: self.id, x_position: 3, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)
		King.create(game_id: self.id, x_position: 4, y_position: 0, player_id: self.white_player_id, color: "white", status: "start", captured: false)
	end

	def populate_black_pieces
		(0..7).each do |num|
			Pawn.create(game_id: self.id, x_position: num, y_position: 6, player_id: self.black_player_id, color: "black", status: "start", captured: false)
		end
		Rook.create(game_id: self.id, x_position: 0, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)
		Rook.create(game_id: self.id, x_position: 7, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)

		Knight.create(game_id: self.id, x_position: 1, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)
		Knight.create(game_id: self.id, x_position: 6, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)

		Bishop.create(game_id: self.id, x_position: 2, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)
		Bishop.create(game_id: self.id, x_position: 5, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)

		Queen.create(game_id: self.id, x_position: 3, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)
		King.create(game_id: self.id, x_position: 4, y_position: 7, player_id: self.black_player_id, color: "black", status: "start", captured: false)
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
