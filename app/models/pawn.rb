class Pawn < Piece

	def valid_move?(x_target, y_target)
		return false unless super
		return true if color == "white" && y_position == 1 && x_position == x_target && y_target == 3 # 1st move & 2 steps
		return true if color == "black" && y_position == 6 && x_position == x_target && y_target == 4 # 1st move & 2 steps

		if color == "white" && move_single_step?(x_target, y_target) && y_target == y_position + 1
			if (x_target - x_position).abs == 1
				if occupied?(x_target, y_target)
					target = Piece.where(game_id: game_id, x_position: x_target, y_position: y_target).first
					return target.color == 'black' ? true : false
				end
			else
				return true if !occupied?(x_target, y_target)
			end
		end

		if color == "black" && move_single_step?(x_target, y_target) && y_target == y_position - 1
			if (x_target - x_position).abs == 1
				if occupied?(x_target, y_target)
					target = Piece.where(game_id: game_id, x_position: x_target, y_position: y_target).first
					return target.color == 'white' ? true : false
				end
			else
				return true if !occupied?(x_target, y_target)
			end
		end
		false
	end



	def capture_en_passant_legal?(x_target, y_target)
    	return true if black_capture_en_passant_is_ok?(x_target, y_target) || white_capture_en_passant_is_ok?(x_target, y_target)
    	false
  	end

  	def white_capture_en_passant_is_ok?(x_target, y_target)
    	return true if white_capture_en_passant_to_right_is_ok?(x_target, y_target) || white_capture_en_passant_to_left_is_ok?(x_target, y_target)
    	false
  	end

  	def white_capture_en_passant_to_right_is_ok?(x_target, y_target)
    	pawn = pawn_at((x_position + 1), 4)
    	return false unless pawn && pawn.is_black && pawn_at((x_position + 1), 4).moves.count == 1
    	return false unless x_target == (x_position + 1) && y_target == 5
    	true
  	end

  	def white_capture_en_passant_to_left_is_ok?(x_target, y_target)
    	pawn = pawn_at((x_position - 1), 4)
    	return false unless pawn && pawn.is_black && pawn_at((x_position - 1), 4).moves.count == 1
    	return false unless x_target == (x_position - 1) && y_target == 5
    	true
  	end

  	def black_capture_en_passant_is_ok?(x_target, y_target)
    	return true if black_capture_en_passant_to_right_is_ok?(x_target, y_target) || black_capture_en_passant_to_left_is_ok?(x_target, y_target)
    	false
  	end

  def black_capture_en_passant_to_right_is_ok?(x_target, y_target)
    pawn = pawn_at((x_position - 1), 3)
    return false unless pawn && !pawn.is_black
    return false unless pawn.moves.count == 1
    return false unless x_target == (x_position - 1) && y_target == 2
    true
  end

  def black_capture_en_passant_to_left_is_ok?(x_target, y_target)
    pawn = pawn_at((x_position + 1), 3)
    return false unless pawn && !pawn.is_black
    return false unless pawn.moves.count == 1
    return false unless x_target == (x_position + 1) && y_target == 2
    true
  end
end 