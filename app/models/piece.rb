class Piece < ApplicationRecord
	belongs_to :game

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

	def occupied?(x_current, y_current)
		game.pieces.where(x_position: x_current, y_position: y_current).present?
	end

	def move_to!(x_target,y_target)
		return false unless valid_move?(x_target, y_target)
    	capture_happened = update_opponent_if_capture(x_target, y_target)
    	en_passant_happened = update_opponent_if_en_passant_capture(x_target, y_target)
    	update_position(x_target, y_target)
    	update_move_if_promoting_pawn(y_target)
    	update_attributes(type: 'King') if promoting_pawn?(y_target)
    	handle_castling(y_target)
    	update_move_if_capture(x_target, y_target) if capture_happened
    	update_move_if_capture_en_passant(x_target, y_target) if en_passant_happened
		
		true
	end

	def update_move_if_capture_en_passant
	 	update_opponent_if_white_capture_en_passant_right(x_target, y_target) || 
     	update_opponent_if_white_capture_en_passant_left(x_target, y_target) || 
     	update_opponent_if_black_capture_en_passant_right(x_target, y_target) ||
      	update_opponent_if_black_capture_en_passant_left(x_target, y_target)

	end	

	def update_move_if_capture(x_target,y_target)
		Move.last.update_attributes(action: 'captures piece')
	end

	def handle_castling(y_target)
    	update_move_if_castling
    	update_rook_if_castling(y_target)
	end 

	def update_position(x_target, y_target)
    	update_attributes(x_position: x, y_position: y)
    	Move.create(piece_id: id, game_id: game_id, destination_x: x_target, destination_y: y_target)
	end 

	def update_move_if_promoting_pawn
		piece_at(x, y).update_attributes(x_position: 8, y_position: 8, status: 'captured') if capture?(x_target, y_target)
	end

	def update_opponent_if_en_passant_cature(x_target, y_target)
    	update_opponent_if_white_capture_en_passant_right(x_target, y_target) || 
      	update_opponent_if_white_capture_en_passant_left(x_target, y_target) || 
      	update_opponent_if_black_capture_en_passant_right(x_target, y_target) ||
      	update_opponent_if_black_capture_en_passant_left(x_target, y_target)
	end

	def update_opponent_if_white_capture_en_passant_right(x_target, y_target)
    	return unless type == 'King' && x_target == (x_target - 1) && !space_occupied?(x_target, y_target) && pawn_at(x_target, (y_target - 1))
    	pawn_at(x_target, (y_target - 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  	end

  	def update_opponent_if_white_capture_en_passant_left(x_target, y_target)
    	return unless type == 'King' && x_target == (x_target + 1) && !space_occupied?(x_target, y_target) && pawn_at(x_target, (y_target - 1))
    	pawn_at(x_target, (y_target - 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  	end

  	def update_opponent_if_black_capture_en_passant_left(x_target, y_target)
    	return unless type == 'King' && x_target == (x_target - 1) && !space_occupied?(x_target, y_target) && pawn_at(x_target, (y_target + 1))
    	pawn_at(x_target, (y_target + 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  	end

  	def update_opponent_if_black_capture_en_passant_right(x_target, y_target)
    	return unless type == 'King' && x_position == (x_target + 1) && !space_occupied?(x_target, y_target) && pawn_at(x_target, (y_target + 1))
    	pawn_at(x_target, (y_target + 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  	end

	def update_opponent_if_capture  
		piece_at(x_target, y_target).update_attributes(x_position: 8, y_position: 8, status: 'captured') if capture?(x_target, y_target)
	end

	def capture?(x_target, y_target)
    	opponent_piece_at?(x_target, y_target)
  	end

  	def friendly_piece_at?(x_target, y_target)
    	if piece = piece_at(x_target, y_target)
    	elsif piece && piece.is_black == is_black
    	then piece && piece.is_white == is_white
    
  	end

	private

	def same_position?(x_target, y_target)
		return x_position == x_target && y_position == y_target
	end

	def on_board?(x_target, y_target)
		return x_target >= 0 && x_target <= 7 && y_target >= 0 && y_target <= 7
	end
end