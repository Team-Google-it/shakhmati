require 'rails_helper'

RSpec.describe Pawn, type: :class do

	describe '.valid_move?' do
		it "should check for valid & invalid moves for an initial position white pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 2, y_position: 1, color: "white")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+1)).to eq(true)
			expect(piece.valid_move?(piece.x_position+0, piece.y_position+2)).to eq(true)

      		expect(piece.valid_move?(piece.x_position+0, piece.y_position+3)).to eq(false)
			expect(piece.valid_move?(piece.x_position-0, piece.y_position-2)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
		end

		it "should check for valid & invalid moves for an initial position black pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 2, y_position: 6, color: "black")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position-1)).to eq(true)
			expect(piece.valid_move?(piece.x_position+0, piece.y_position-2)).to eq(true)

      		expect(piece.valid_move?(piece.x_position+0, piece.y_position-3)).to eq(false)
			expect(piece.valid_move?(piece.x_position-0, piece.y_position+2)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
		end

		it "should check for valid & invalid moves for a white pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 4, y_position: 4, color: "white")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+1)).to eq(true)

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+2)).to eq(false)
			expect(piece.valid_move?(piece.x_position-0, piece.y_position-1)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
		end

		it "should check for valid & invalid moves for a black pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 4, y_position: 4, color: "black")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position-1)).to eq(true)

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-0, piece.y_position-2)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to eq(false)
		end

		it "should check for invalid moves for a pawn with obstructions (same color)" do
			game = Game.create!()
			piece1 = Pawn.create(game_id: game.id, x_position: 4, y_position: 1, color: "white")
			piece2 = Pawn.create(game_id: game.id, x_position: 3, y_position: 2, color: "white")
			piece3 = Pawn.create(game_id: game.id, x_position: 4, y_position: 2, color: "white")
<<<<<<< HEAD
			piece2 = Pawn.create(game_id: game.id, x_position: 5, y_position: 2, color: "white")
=======
			piece4 = Pawn.create(game_id: game.id, x_position: 5, y_position: 2, color: "white")
>>>>>>> 8f0979daec0084134aa7c1da16540da50fe987a2

			expect(piece1.valid_move?(piece1.x_position-1, piece1.y_position+1)).to eq(false)
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+1)).to eq(false)
			expect(piece1.valid_move?(piece1.x_position+1, piece1.y_position+1)).to eq(false)
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+2)).to eq(false)
		end

		it "should check for invalid moves for a pawn with obstructions (opposite color)" do
			game = Game.create!()
			piece1 = Pawn.create(game_id: game.id, x_position: 4, y_position: 1, color: "white")
			piece2 = Pawn.create(game_id: game.id, x_position: 3, y_position: 2, color: "black")
			piece3 = Pawn.create(game_id: game.id, x_position: 4, y_position: 2, color: "black")
<<<<<<< HEAD
			piece2 = Pawn.create(game_id: game.id, x_position: 5, y_position: 2, color: "black")
=======
			piece4 = Pawn.create(game_id: game.id, x_position: 5, y_position: 2, color: "black")
>>>>>>> 8f0979daec0084134aa7c1da16540da50fe987a2

			expect(piece1.valid_move?(piece1.x_position-1, piece1.y_position+1)).to eq(true)
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+1)).to eq(false)
			expect(piece1.valid_move?(piece1.x_position+1, piece1.y_position+1)).to eq(true)
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+2)).to eq(false)
		end
	end
end