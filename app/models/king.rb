class King < Piece

	def valid_move?(x_target, y_target)
		x_distance = (x_target - x_position).abs
		y_distance = (y_target - y_position).abs
		return false if same_position?(x_target, y_target)
		return false if !on_board?(x_target, y_target)
		return true if (x_distance == 0 && y_distance == 1) || (x_distance == 1 && y_distance == 0) || (x_distance == 1 && y_distance == 1)
		return false
	end
end
