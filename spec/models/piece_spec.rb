require 'rails_helper'

RSpec.describe Piece, type: :model do

	describe "#is_obstructed?" do
		it "should return true if piece path is obstructed vertically UP" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 0)
			Pawn.create!(game_id: g.id, x_position: 0, y_position: 1)

			result = p.is_obstructed?(0,3)
			expect(result).to be true
		end

		it "should return true if piece path is obstructed vertically DOWN" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 3)
			Pawn.create!(game_id: g.id, x_position: 0, y_position: 1)

			result = p.is_obstructed?(0,0)
			expect(result).to be true
		end

		it "should return false if piece path is not obstructed vertically UP" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 2)

			result = p.is_obstructed?(0,4)
			expect(result).to be false
		end

		it "should return false if piece path is not obstructed vertically DOWN" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 4)

			result = p.is_obstructed?(0,2)
			expect(result).to be false
		end

		it "should return true if piece path is obstructed horizontally RIGHT" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 0)
			Knight.create!(game_id: g.id, x_position: 1, y_position: 0)

			result = p.is_obstructed?(3,0)
			expect(result).to be true
		end

		it "should return true if piece path is obstructed horizontally LEFT" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 3, y_position: 0)
			Knight.create!(game_id: g.id, x_position: 1, y_position: 0)

			result = p.is_obstructed?(0,0)
			expect(result).to be true
		end

		it "should return false if piece path is not obstructed horizontally RIGHT" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 0, y_position: 2)

			result = p.is_obstructed?(3,2)
			expect(result).to be false
		end

		it "should return false if piece path is not obstructed horizontally LEFT" do
			g = Game.create!()
			p = Rook.create!(game_id: g.id, x_position: 3, y_position: 2)

			result = p.is_obstructed?(0,2)
			expect(result).to be false
		end

		it "should return true if piece path is obstructed diagonally UP RIGHT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 2, y_position: 2)
			Pawn.create!(game_id: g.id, x_position: 4, y_position: 4)

			result = p.is_obstructed?(5,5)
			expect(result).to be true
		end

		it "should return true if piece path is obstructed diagonally UP LEFT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 2, y_position: 2)
			Pawn.create!(game_id: g.id, x_position: 1, y_position: 3)

			result = p.is_obstructed?(0,4)
			expect(result).to be true
		end

		it "should return true if piece path is obstructed diagonally DOWN RIGHT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 5, y_position: 5)
			Pawn.create!(game_id: g.id, x_position: 6, y_position: 4)

			result = p.is_obstructed?(7,3)
			expect(result).to be true
		end

		it "should return true if piece path is obstructed diagonally DOWN LEFT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 5, y_position: 5)
			Pawn.create!(game_id: g.id, x_position: 4, y_position: 4)

			result = p.is_obstructed?(3,3)
			expect(result).to be true
		end

		it "should return false if piece path is obstructed diagonally UP RIGHT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 2, y_position: 2)

			result = p.is_obstructed?(4,4)
			expect(result).to be false
		end

		it "should return false if piece path is obstructed diagonally UP LEFT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 4, y_position: 3)

			result = p.is_obstructed?(2,5)
			expect(result).to be false
		end

		it "should return false if piece path is obstructed diagonally DOWN RIGHT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 5, y_position: 5)

			result = p.is_obstructed?(7,3)
			expect(result).to be false
		end

		it "should return false if piece path is obstructed diagonally DOWN LEFT" do
			g = Game.create!()
			p = Bishop.create!(game_id: g.id, x_position: 5, y_position: 5)

			result = p.is_obstructed?(3,3)
			expect(result).to be false
		end

		it "should raise an error message if piece makes an invalid move" do
			g = Game.create!()
			p = Knight.create!(game_id: g.id, x_position: 3, y_position: 3)

			result = p.is_obstructed?(1,4)
			expect(result).to be false
		end
	end

	describe "#move_to" do
		it "should replace a piece if opposite color" do
			g = Game.create!()
			p1 = Pawn.create(game_id: g.id, x_position: 2, y_position: 2, color: "white")
			p2 = Pawn.create(game_id: g.id, x_position: 3, y_position: 3, color: "black")

			p1.move_to(3,3)
			p2.reload
			expect(p2.x_position).to eq(nil)
			expect(p1.x_position).to eq(3)
		end 

		it "should return false if piece is same color" do
			g = Game.create!()
			p1 = Rook.create(game_id: g.id, x_position: 2, y_position: 2, color: "white")
			p2 = Rook.create(game_id: g.id, x_position: 2, y_position: 3, color: "white")

			result = p1.move_to(2,3)
			expect(result).to be false
		end

		it "should change piece location if empty" do
			g = Game.create!()
			p = Pawn.create(game_id: g.id, x_position: 2, y_position: 2, color: "white")

			p.move_to(2,3)
			expect(p.y_position).to eq(3)
		end
    end
end
