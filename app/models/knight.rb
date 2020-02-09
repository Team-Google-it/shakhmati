class Knight < Piece

 	def valid_move?(x_target, y_target)
    	return false unless super
    	return true if upper_right_diagonal_legal?(x_target, y_target)
    	return true if lower_right_diagonal_legal?(x_target, y_target)
    	return true if upper_left_diagonal_legal?(x_target, y_target)
    	return true if lower_left_diagonal_legal?(x_target, y_target)
    	false
	end

  def obstructed?(*)
    false
  end

  def upper_right_diagonal_legal?(x_target, y_target)
    	(x_position + 1 == x_target && y_position - 2 == y_target) || (x_position + 2 == x_target && y_position - 1 == y_target)
  end

  def lower_right_diagonal_legal?(x_target, y_target)
    	(x_position + 2 == x_target && y_position + 1 == y_target) || (x_position + 1 == x_target && y_position + 2 == y_target)
  end

  def upper_left_diagonal_legal?(x_target, y_target)
    	(x_position - 2 == x_target && y_position - 1 == y_target) || (x_position - 1 == x_target && y_position - 2 == y_target)
  end

  def lower_left_diagonal_legal?(x_target, y_target)
    	(x_position - 1 == x_target && y_position + 2 == y_target) || (x_position - 2 == x_target && y_position + 1 == y_target)
 	end

end