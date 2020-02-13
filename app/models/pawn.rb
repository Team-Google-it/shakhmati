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
        return true if en_passant?(x_target, y_target)
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
        return true if en_passant?(x_target, y_target)
			else
				return true if !occupied?(x_target, y_target)
			end
		end
		false
	end

  def en_passant?(x_target, y_target)
    if color == 'white' && y_position == 4 && y_target == 5
      if (x_target - x_position).abs == 1
        if occupied?(x_target, y_target - 1)
          target = Piece.where(game_id: game_id, x_position: x_target, y_position: 4).first
          return target.color == 'black' ? true : false
        end
      else
        false
      end
    end

    if color == 'black' && y_position == 3 && y_target == 2
      if (x_target - x_position).abs == 1
        if occupied?(x_target, y_target + 1)
          target = Piece.where(game_id: game_id, x_position: x_target, y_position: 3).first
          return target.color == 'white' ? true : false
        end
      else
        false
      end
    end
  end
end 