class Rook < Piece
	def move_valid?(x_target, y_target)
    	return false unless vertical_move?(x_target, y_target) || horizontal_move?(x_target, y_target)
    	return false if is_obstructed?(x_target, y_target)
    	return false if friendly_piece_at?(x_target, y_target)
    	true
  	end

end 