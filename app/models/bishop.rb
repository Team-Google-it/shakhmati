class Bishop < Piece

	def move_valid?(x_target, y_target)
    # if landing spot is occupied, check to see if is opponent's piece
    if space_occupied?(x_target, y_target)
      return false if is_black == opponent_color(x_target, y_target) # return false if piece is same color
    end
    return false if legal_move?(x_target, y_target) == false
    true
  end

  def legal_move?(x_target, y_target)
    return true if diagonal_move?(x_target, y_target) && !path_obstructed?(x_target, y_target)
    false
  end

end
