#require 'rails_helper'
#
#RSpec.describe Game, type: :model do
#
#	describe "#is_obstructed?" do
#		it "should return false if piece is not obstructed diagonally" do
#			g = Game.create!()
#			Bishop.create!(game_id: g.id, x_position: 0, y_position: 5)
#			Pawn.create!(game_id: g.id, x_position: 2, y_position: 3)
#
#			result = g.is_obstructed?(0,5,2,3)
#			expect(result).to be false
#		end
#	end
#
#end
