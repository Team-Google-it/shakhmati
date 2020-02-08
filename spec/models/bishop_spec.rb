require 'rails_helper'

RSpec.describe Bishop, type: :class do


	describe '#valid_move?' do
		# it "should check for valid move for a Bishop" do
		# 	g = Game.create!()
		# 	p = Bishop.create(game_id: g.id, x_position: 4, y_position: 4, color: "white")
		# 	Pawn.create(game_id: g.id, x_position: 6, y_position: 6, color: "black")
		# 	expect(p.valid_move?(p.x_position+1, p.y_position+1)).to be true
		# 	expect(p.valid_move?(p.x_position-2, p.y_position+2)).to be true
		# 	expect(p.valid_move?(p.x_position+2, p.y_position-2)).to be true
		# 	expect(p.valid_move?(p.x_position-2, p.y_position-2)).to be true
		# 	expect(p.valid_move?(p.x_position+2, p.y_position+2)).to be true
		# end
		it "should check for invalid move for a Bishop" do
			g = Game.create!()
			p = Bishop.create(game_id: g.id, x_position: 4, y_position: 4, color: "white")
			Pawn.create(game_id: g.id, x_position: 5, y_position: 5, color: "white")
			# expect(p.valid_move?(p.x_position+0, p.y_position+0)).to be false
			# expect(p.valid_move?(p.x_position+0, p.y_position+2)).to be false
			# expect(p.valid_move?(p.x_position+2, p.y_position+0)).to be false
			# expect(p.valid_move?(p.x_position-2, p.y_position-0)).to be false
			# expect(p.valid_move?(p.x_position+0, p.y_position-2)).to be false
			# expect(p.valid_move?(p.x_position+2, p.y_position-3)).to be false
			# expect(p.valid_move?(p.x_position+2, p.y_position+2)).to be false
			expect(p.valid_move?(p.x_position+1, p.y_position+1)).to be false
		end
	end
end