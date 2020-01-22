require 'rails_helper'

RSpec.describe Piece, type: :model do

	describe "#is_obstructed?" do
		it "should return true if piece path is obstructed vertically" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 0)
			Pawn.create!(game_id: g.id, x_position: 0, y_position: 1)

			result = p.is_obstructed?(0,3)
			expect(result).to eq(true)
		end

		it "should return false if piece path is not obstructed vertically" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 0)

			result = p.is_obstructed?(0,3)
			expect(result).to eq(false)
		end
	end

end
