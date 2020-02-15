class Piece < ApplicationRecord
	belongs_to :game

	def move_to(x_target, y_target)
		return false unless valid_move?(x_target, y_target)
		capture(x_target, y_target) if occupied?(x_target, y_target)
		update_attributes!(x_position: x_target, y_position: y_target)
		game.pieces.reload
		if checking?()
			game.update_attributes!(status: "in_check")
		end
		game.update_attributes!(last_piece_x: x_target, last_piece_y: y_target)
		true
	end

	def occupied?(x_current, y_current)
		game.piece_at(x_current, y_current).present?
	end

	def capture(x_target, y_target)
    	target = find_piece(x_target, y_target)
    	target.update_attributes!(captured: true, x_position: nil, y_position: nil) if color != target.color
  	end

  	def find_piece(x_target, y_target)
  		game.piece_at(x_target, y_target)
  	end

  	def valid_move?(x_target, y_target)
  		target = find_piece(x_target, y_target)
  		return false if same_position?(x_target, y_target)
  		return false unless on_board?(x_target, y_target)
  		return false if occupied?(x_target, y_target) && color == target.color
  		return false if is_obstructed?(x_target, y_target)
  		true
  	end

  	def king_in_check?(king_x, king_y)
  		opponent_pieces.each do |opponent|
  			return true if opponent.valid_move?(king_x, king_y)
  		end
  		false
  	end

  	def checking?
  		opponent_king = game.pieces.where(type: 'King', color: opponent_color).first
  		pieces = game.pieces.where(color: color, captured: false)
  		pieces.each do |piece|
  			return true if piece.valid_move?(opponent_king.x_position.to_i, opponent_king.y_position.to_i)
  		end
  		false
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

	def opponent_pieces
    	game.pieces.where(color: opponent_color, captured: false)
  	end
end
