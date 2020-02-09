class Queen < Piece
	def valid_move?(x_target, y_target)
		return false unless super
	    return true if vertical_move?(x_target, y_target) || horizontal_move?(x_target, y_target) || diagonal_move?(x_target, y_target)
	    false
  	end
  end
