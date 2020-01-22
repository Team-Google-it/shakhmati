class Piece < ApplicationRecord
	belongs_to :game

	def is_obstructed?(x_target, y_target)
		case 
			when vertical_move?(x_target, y_target)
				vertical_obstruction?(y_target)
			else
				false
		end
	end

	def vertical_move?(x_target, y_target)
		x_position == x_target && y_position != y_target
	end

	def vertical_obstruction?(y_target)
		direction = y_target > y_position ? 1 : -1
		(y_position + direction).step(y_target - direction, direction) do |y_current|
			return true if occupied?(x_position, y_current)
		end
		false
	end

	def occupied?(x_current, y_current)
		game.pieces.where(x_position: x_current, y_position: y_current).present?
	end
end