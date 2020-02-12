class Piece < ApplicationRecord
	belongs_to :game

	def move_to(x_target,y_target)
		return false unless valid_move?(x_target, y_target)
		capture(x_target, y_target) if occupied?(x_target, y_target)
		update_attributes!(x_position: x_target, y_position: y_target, status: "moved")
		if checking?
			game.update_attributes(status: "in_check")
		end
		true
	end

	def occupied?(x_current, y_current)
		game.pieces.where(x_position: x_current, y_position: y_current).present?
	end

	def capture(x_target, y_target)
    	target = find_piece(x_target, y_target)
    	target.update_attributes!(status: 'captured', x_position: nil, y_position: nil) if color != target.color
  	end

  	def find_piece(x_target, y_target)
  		return game.pieces.where(x_position: x_target, y_position: y_target).first
  	end

  	def find_last_piece(x_target, y_target)
  		return game.pieces.where(last_move_x: x_target, last_move_y: y_target).first
  	end

  	def valid_move?(x_target, y_target)
  		target = find_piece(x_target, y_target)
  		return false if same_position?(x_target, y_target)
  		return false unless on_board?(x_target, y_target)
  		return false if occupied?(x_target, y_target) && color == target.color
  		return false if is_obstructed?(x_target, y_target)
  		true
  	end

  	def checking?
  		opponent_king = game.pieces.where(type: 'King', color: opponent_color).first
  		pieces = game.pieces.where(color: color)
  		pieces.each do |piece|
  			return true if piece.valid_move?(opponent_king.x_position.to_i, opponent_king.y_position.to_i)
  		end
  		false
  	end

  	def castle!(rook_x, rook_y)
  		rook = find_piece(rook_x, rook_y)
  		king = find_piece(4, rook_y)
  		if rook_x == 0
  			rook.update_attributes!(x_position: 3)
  			king.update_attributes!(x_position: 2)
  		else
  			rook.update_attributes!(x_position: 5)
  			king.update_attributes!(x_posiiton: 6)
  		end
  	end


  	def is_obstructed?(x_target, y_target)
		case
			when vertical_move?(x_target, y_target)
				vertical_obstruction?(y_target)
			when horizontal_move?(x_target, y_target)
				horizontal_obstruction?(x_target)
			when diagonal_move?(x_target, y_target)
				diagonal_obstruction?(x_target, y_target)
			else
				false
		end
	end

	def vertical_move?(x_target, y_target)
		x_position == x_target && y_position != y_target
	end

	def horizontal_move?(x_target, y_target)
		x_position != x_target && y_position == y_target
	end

	def diagonal_move?(x_target, y_target)
		(x_target - x_position).abs == (y_target - y_position).abs
	end

	def vertical_obstruction?(y_target)
		direction = y_target > y_position ? 1 : -1
		(y_position + direction).step(y_target - direction, direction) do |y_current|
			return true if occupied?(x_position, y_current)
		end
		false
	end

	def horizontal_obstruction?(x_target)
		direction = x_target > x_position ? 1 : -1
		(x_position + direction).step(x_target - direction, direction) do |x_current|
			return true if occupied?(x_current, y_position)
		end
		false
	end

	def diagonal_obstruction?(x_target, y_target)
    	x_direction = x_target > x_position ? 1 : -1
    	y_direction = y_target > y_position ? 1 : -1
    	(x_position + x_direction).step(x_target - x_direction, x_direction) do |x_current|
      		y_current = y_position + ((x_current - x_position).abs * y_direction)
      		return true if occupied?(x_current, y_current)
    	end
    	false
  	end

  	def can_castle?(rook_x, rook_y)
  		rook = find_piece(rook_x, rook_y)
  		king = find_piece(4, rook_y)
  		return false if king.type != "King" || rook.type != "Rook"
  		return false if king.status == "moved" || rook.status == "moved"
  		return false if king.is_obstructed?(rook_x, rook_y)
  		true
  	end

  	private

  	def move_single_step?(x_target, y_target)
  		x_distance = (x_target - x_position).abs
  		y_distance = (y_target - y_position).abs
  		x_distance <= 1 && y_distance <= 1 ? true : false
  	end

	def same_position?(x_target, y_target)
		x_position == x_target && y_position == y_target
	end

	def on_board?(x_target, y_target)
		x_target >= 0 && x_target <= 7 && y_target >= 0 && y_target <= 7
	end

	def opponent_color
		return "black" if color == "white"
		"white"
	end

end
