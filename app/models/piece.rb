class Piece < ApplicationRecord
	belongs_to :game

	def move_to(x_target, y_target)
		return false unless valid_move?(x_target, y_target)
		capture(x_target, y_target) if occupied?(x_target, y_target)
		update_attributes!(x_position: x_target, y_position: y_target)
		if check?(color)
			game.update_attributes!(status: "in_check")
		end
		if checkmate?(color)
			game.update_attributes!(status: "checkmate")
		end
		game.update_attributes!(last_piece_x: x_target, last_piece_y: y_target)
		true
	end

	def occupied?(x_current, y_current)
		game.pieces.where(x_position: x_current, y_position: y_current).present?
	end

	def capture(x_target, y_target)
    	target = find_piece(x_target, y_target)
    	target.update_attributes!(captured: true, x_position: nil, y_position: nil) if color != target.color
  	end

  	def find_piece(x_target, y_target)
  		return game.pieces.where(x_position: x_target, y_position: y_target).first
  	end

  	def find_last_piece(x_target, y_target)
  		return Piece.find_by(x_position: x_target, y_position: y_target, game_id: game.id)
  	end

  	def valid_move?(x_target, y_target)
  		target = find_piece(x_target, y_target)
  		return false if same_position?(x_target, y_target)
  		return false unless on_board?(x_target, y_target)
  		return false if occupied?(x_target, y_target) && color == target.color
  		return false if is_obstructed?(x_target, y_target)
  		true
  	end

  	def can_be_captured?(x_current, y_current)
  		opponent_pieces.each do |opponent|
  			return true if opponent.valid_move?(x_current, y_current)
  		end
  		false
  	end

  	def can_be_blocked?(x_target, y_target)
  		case
			when vertical_move?(x_target, y_target)
				vertical_target?(x_target, y_target)
			when horizontal_move?(x_target, y_target)
				horizontal_target?(x_target, y_target)
			when diagonal_move?(x_target, y_target)
				diagonal_target?(x_target, y_target)
			else
				false
		end
  	end

  	def check?(color)
  		king = game.pieces.where(type: 'King', color: color).first
  		opponent_pieces.each do |piece|
  			if piece.valid_move?(king.x_position, king.y_position)
  				@piece_causing_check = piece
  				return true
  			end
  		end
  		false
  	end

  	def checkmate?(color)
  		checked_king = game.pieces.where(type: 'King', color: color).first

  		return false unless check?(color)
  		return false if @piece_causing_check.can_be_captured?(@piece_causing_check.x_position, @piece_causing_check.y_position)
  		return false if checked_king.can_move_out_of_check?(checked_king.x_position, checked_king.y_position)
  		return false if @piece_causing_check.can_be_blocked?(checked_king.x_position, checked_king.y_position)

  		true
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

  	def vertical_target?(y_target)
		direction = y_target > y_position ? 1 : -1
		(y_position + direction).step(y_target - direction, direction) do |y_current|
			return true if can_be_captured?(x_position, y_current)
		end
		false
	end

	def horizontal_target?(x_target)
		direction = x_target > x_position ? 1 : -1
		(x_position + direction).step(x_target - direction, direction) do |x_current|
			return true if can_be_captured?(x_current, y_position)
		end
		false
	end

	def diagonal_target?(x_target, y_target)
    	x_direction = x_target > x_position ? 1 : -1
    	y_direction = y_target > y_position ? 1 : -1
    	(x_position + x_direction).step(x_target - x_direction, x_direction) do |x_current|
      		y_current = y_position + ((x_current - x_position).abs * y_direction)
      		return true if can_be_captured?(x_current, y_current)
    	end
    	false
  	end

  	def opponent_color
		return "black" if color == "white"
		"white"
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

	def opponent_pieces
    	game.pieces.where(color: opponent_color, captured: false)
  	end
end
