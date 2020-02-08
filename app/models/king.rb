class King < Piece

	def valid_move?(x_target, y_target)
		return false unless super
		return true if move_single_step?(x_target, y_target)
		return false
	end
end
