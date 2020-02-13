class King < Piece

	def valid_move?(x_target, y_target)
		return false unless super
		return true if can_castle?(x_target, y_target)
		return true if move_single_step?(x_target, y_target)
		return false
	end

	def move_to(x_target, y_target)
		return false unless valid_move?(x_target, y_target)
		return false if king_in_check?(x_target, y_target)
		capture(x_target, y_target) if occupied?(x_target, y_target)
		if can_castle?(x_target, y_target)
			rook = castling_rook(x_target, y_target)
			rook.move_castled_rook(x_target, y_target)
		end
		update_attributes!(x_position: x_target, y_position: y_target, status: 'moved')
		game.update_attributes(status: "in_check") if checking?
		true
	end

	def can_castle?(x_target, y_target)
		return false unless allowed_castling_target?(x_target, y_target)
		return false if status == "moved"
		castled_rook = castling_rook(x_target, y_target)
		return false if castled_rook == nil
		return false if castled_rook.status == "moved"
		return false if game.status == "in_check"
		king_target = [x_target, y_target]
		case king_target
		when [2,0]
			return false if king_in_check?(3,0) || occupied?(3,0) || occupied?(1,0)
		when [6,0]
			return false if king_in_check?(5,0) || occupied?(5,0)
		when [2,7]
			return false if king_in_check?(3,7) || occupied?(3,7) || occupied?(1,7)
		when [6,7]
			return false if king_in_check?(5,7) || occupied?(5,7)
		else
			nil
		end
		true
	end

	def allowed_castling_target?(x_target, y_target)
		if color == 'white'
			return true if (x_target == 2 || x_target == 6) && y_target == 0
		else
			return true if (x_target == 2 || x_target == 6) && y_target == 7
		end
		false
	end

	def castling_rook(x_target, y_target)
		king_target = [x_target, y_target]
		case king_target
		when [2,0]
			return game.pieces.where(x_position: 0, y_position: 0).first
		when [6,0]
			return game.pieces.where(x_position: 7, y_position: 0).first
		when [2,7]
			return game.pieces.where(x_position: 0, y_position: 7).first
		when [6,7]
			return game.pieces.where(x_position: 7, y_position: 7).first
		else
			nil
		end
	end
end
