class Knight < Piece

 	def move_valid?(x_target, y_target)
    	return false if friendly_piece_at?(x_target, y_target)
    	return true if upper_right_diagonal_legal?(x_target, y_target)
    	return true if lower_right_diagonal_legal?(x_target, y_target)
    	return true if upper_left_diagonal_legal?(x_target, y_target)
    	return true if lower_left_diagonal_legal?(x_target, y_target)
    	false
	end

  	def upper_right_diagonal_legal?(x_target, y_target)
    	(x_position + 1 == x && y_position - 2 == y) || (x_position + 2 == x && y_position - 1 == y)
  	end

  	def lower_right_diagonal_legal?(x_target, y_target)
    	(x_position + 2 == x && y_position + 1 == y) || (x_position + 1 == x && y_position + 2 == y)
  	end

  	def upper_left_diagonal_legal?(x_target, y_target)
    	(x_position - 2 == x && y_position - 1 == y) || (x_position - 1 == x && y_position - 2 == y)
  	end

  	def lower_left_diagonal_legal?(x_target, y_target)
    	(x_position - 1 == x && y_position + 2 == y) || (x_position - 2 == x && y_position + 1 == y)
 	end

end