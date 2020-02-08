class Bishop < Piece
	def valid_move?(x_target, y_target)
      return false unless super
      return true if diagonal_move?(x_target, y_target)
      false
    end
end
