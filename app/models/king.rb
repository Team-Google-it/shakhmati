class King < Piece

	def valid_move?(x_target, y_target)
		return false unless super
		return true if move_single_step?(x_target, y_target)
		return true if can_castle?(x_target+1, y_target) || can_castle?(x_target-1, y_target)
		return false
	end
end
