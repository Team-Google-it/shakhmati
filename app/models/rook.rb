class Rook < Piece
	def valid_move?(x_target, y_target)
		return false unless super
	    return true if vertical_move?(x_target, y_target) || horizontal_move?(x_target, y_target)
	    false
  	end

  	def move_castled_rook(x_target, y_target)
  		king_target = [x_target, y_target]
		case king_target
			when [2,0]
				update(x_position: 3, y_position: 0)
			when [6,0]
				update(x_position: 5, y_position: 0)
			when [2,7]
				update(x_position: 3, y_position: 7)
			when [6,7]
				update(x_position: 5, y_position: 7)
			else
				nil
		end
	end
end 
