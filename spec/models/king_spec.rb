require 'rails_helper'

RSpec.describe King, type: :class do


	describe '#valid_move?' do
		it "should check for valid move for a King" do
			g = Game.create!()
			p = King.create(game_id: g.id, x_position: 4, y_position: 4, color: "white")
			expect(p.valid_move?(p.x_position+1, p.y_position+0)).to eq(true)
			expect(p.valid_move?(p.x_position-1, p.y_position+0)).to eq(true)
			expect(p.valid_move?(p.x_position+0, p.y_position+1)).to eq(true)
			expect(p.valid_move?(p.x_position+0, p.y_position-1)).to eq(true)
		end
		it "should check for invalid move for a King" do
			g = Game.create!()
			p = King.create(game_id: g.id, x_position: 0, y_position: 4, color: "white")
			expect(p.valid_move?(p.x_position+0, p.y_position+0)).to eq(false)
			expect(p.valid_move?(p.x_position+2, p.y_position+0)).to eq(false)
			expect(p.valid_move?(p.x_position-3, p.y_position+0)).to eq(false)
			expect(p.valid_move?(p.x_position+0, p.y_position+2)).to eq(false)
			expect(p.valid_move?(p.x_position+0, p.y_position-3)).to eq(false)
			expect(p.valid_move?(p.x_position+2, p.y_position-3)).to eq(false)
		end
	end
end