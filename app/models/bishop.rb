class Bishop < Piece
	def valid_move?(x_target, y_target)
      return false if same_position?(x_target, y_target)
      return false if !on_board?(x_target, y_target)
      return false if is_obstructed?(x_target, y_target)
      return true if diagonal_move?(x_target, y_target)
      false
    end
  
    return false if legal_move?(x_target, y_target) == false
    return true
  end

  def legal_move?(x_target, y_target)
    return true if diagonal_move?(x_target, y_target) && !path_obstructed?(x_target, y_target)
    return false
  end
end
