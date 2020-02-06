class Queen < Piece
	def valid_move?(x_target, y_target)
		return false if same_position?(x_target, y_target)
		return false if !on_board?(x_target, y_target)
		return false if is_obstructed?(x_target, y_target)
	    return true if vertical_move?(x_target, y_target) || horizontal_move?(x_target, y_target) || diagonal_move?(x_target, y_target)
	    false
  	end
  end
