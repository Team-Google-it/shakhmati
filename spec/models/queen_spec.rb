require 'rails_helper'

RSpec.describe Queen, type: :class do


	describe '#valid_move?' do
		it "should check for valid move for a Queen" do
			g = Game.create!()
			p = Queen.create(game_id: g.id, x_position: 4, y_position: 4, color: "white")
			expect(p.valid_move?(p.x_position+2, p.y_position+2)).to eq(true)
			expect(p.valid_move?(p.x_position-2, p.y_position+2)).to eq(true)
			expect(p.valid_move?(p.x_position+2, p.y_position-2)).to eq(true)
			expect(p.valid_move?(p.x_position-2, p.y_position-2)).to eq(true)
			expect(p.valid_move?(p.x_position+2, p.y_position+0)).to eq(true)
			expect(p.valid_move?(p.x_position-2, p.y_position+0)).to eq(true)
			expect(p.valid_move?(p.x_position+0, p.y_position+2)).to eq(true)
			expect(p.valid_move?(p.x_position+0, p.y_position-2)).to eq(true)
		end
		it "should check for invalid move for a Queen" do
			g = Game.create!()
			p = Queen.create(game_id: g.id, x_position: 4, y_position: 4, color: "white")
			obs = Pawn.create(game_id: g.id, x_position: 5, y_position: 5, color: "white")
			expect(p.valid_move?(p.x_position+0, p.y_position+0)).to eq(false)
			expect(p.valid_move?(p.x_position+2, p.y_position-3)).to eq(false)
			expect(p.valid_move?(p.x_position+2, p.y_position+2)).to eq(false)
		end
	end
end