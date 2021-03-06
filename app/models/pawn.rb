class Pawn < Piece

	def valid_move?(x_target, y_target)
		return false unless super

		return true if color == "white" && y_position == 1 && x_position == x_target && y_target == 3 && !occupied?(x_target, y_target)# 1st move & 2 steps
		return true if color == "black" && y_position == 6 && x_position == x_target && y_target == 4 && !occupied?(x_target, y_target)# 1st move & 2 steps

		if color == "white" && move_single_step?(x_target, y_target) && y_target == y_position + 1
			if (x_target - x_position).abs == 1
				target = find_piece(x_target, y_target)
				return target&.color == 'black' || en_passant?(x_target, y_target)
			else
				return true if !occupied?(x_target, y_target)
			end
		end

		if color == "black" && move_single_step?(x_target, y_target) && y_target == y_position - 1
			if (x_target - x_position).abs == 1
				target = find_piece(x_target, y_target)
				return target&.color == 'white' || en_passant?(x_target, y_target)
			else
				return true if !occupied?(x_target, y_target)
			end
		end
		false
	end

  def en_passant?(x_target, y_target)
    target = game.piece_at(game.last_piece_x, game.last_piece_y)
		if target
	    if color == 'white' && y_position == 4 && y_target == 5 && (x_position - x_target).abs == 1 && target.y_position == y_position
        	if occupied?(x_target, y_target - 1)
				capture(game.last_piece_x, game.last_piece_y)
          		return target.color == 'black' ? true : false
        	end
	    elsif color == 'black' && y_position == 3 && y_target == 2 && (x_position - x_target).abs == 1 && target.y_position == y_position
        if occupied?(x_target, y_target + 1)
			capture(game.last_piece_x, game.last_piece_y)
          	return target.color == 'white' ? true : false
        end
	    end
		end
		false
	end
end
