require 'rails_helper'

RSpec.describe Pawn, type: :class do

	describe 'valid_move?' do
		it "should check for valid & invalid moves for an initial position white pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 2, y_position: 1, color: "white")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+1)).to be true
			expect(piece.valid_move?(piece.x_position+0, piece.y_position+2)).to be true

      		expect(piece.valid_move?(piece.x_position+0, piece.y_position+3)).to be false
			expect(piece.valid_move?(piece.x_position+0, piece.y_position-2)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+2, piece.y_position+1)).to be false
		end

		it "should check for valid & invalid moves for an initial position black pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 2, y_position: 6, color: "black")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position-1)).to be true
			expect(piece.valid_move?(piece.x_position+0, piece.y_position-2)).to be true

			expect(piece.valid_move?(piece.x_position+0, piece.y_position-3)).to be false
			expect(piece.valid_move?(piece.x_position+0, piece.y_position+2)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+2, piece.y_position-1)).to be false
		end

		it "should check for valid & invalid moves for a white pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 4, y_position: 4, color: "white")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+1)).to be true

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+2)).to be false
			expect(piece.valid_move?(piece.x_position+0, piece.y_position-1)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+2, piece.y_position+1)).to be false
		end

		it "should check for valid & invalid moves for a black pawn" do
			game = Game.create!()
			piece = Pawn.create(game_id: game.id, x_position: 4, y_position: 4, color: "black")

			expect(piece.valid_move?(piece.x_position+0, piece.y_position-1)).to be true

			expect(piece.valid_move?(piece.x_position+0, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+0, piece.y_position-2)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+0)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+1, piece.y_position-1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position-1, piece.y_position+1)).to be false
			expect(piece.valid_move?(piece.x_position+2, piece.y_position-1)).to be false
		end

		it "should check for invalid moves for a pawn with obstructions (same color)" do
			game = Game.create!()
			piece1 = Pawn.create(game_id: game.id, x_position: 4, y_position: 1, color: "white")
			piece2 = Pawn.create(game_id: game.id, x_position: 3, y_position: 2, color: "white")
			piece3 = Pawn.create(game_id: game.id, x_position: 4, y_position: 2, color: "white")
			piece4 = Pawn.create(game_id: game.id, x_position: 5, y_position: 2, color: "white")

			expect(piece1.valid_move?(piece1.x_position-1, piece1.y_position+1)).to be false
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+1)).to be false
			expect(piece1.valid_move?(piece1.x_position+1, piece1.y_position+1)).to be false
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+2)).to be false
		end

		it "should check for valid & invalid moves for a pawn with obstructions (opposite color)" do
			game = Game.create!()
			piece1 = Pawn.create(game_id: game.id, x_position: 4, y_position: 1, color: "white")
			piece2 = Pawn.create(game_id: game.id, x_position: 3, y_position: 2, color: "black")
			piece3 = Pawn.create(game_id: game.id, x_position: 4, y_position: 2, color: "black")
			piece4 = Pawn.create(game_id: game.id, x_position: 5, y_position: 2, color: "black")

			expect(piece1.valid_move?(piece1.x_position-1, piece1.y_position+1)).to be true
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+1)).to be false
			expect(piece1.valid_move?(piece1.x_position+1, piece1.y_position+1)).to be true
			expect(piece1.valid_move?(piece1.x_position+0, piece1.y_position+2)).to be false
		end

	
		it 'should allow white capture en passant following regular chess rules' do
    		game = Game.create!()
    		white_pawn = Pawn.create(game_id: game.id, x_position: 4, y_position: 4, color: "white")
    		black_pawn = Pawn.create(game_id: game.id, x_position: 5, y_position: 6, color: "black")
    		black_pawn.move_to(5, 4)
    		expect(white_pawn.valid_move?(5, 5)).to be true
  		end

  		it 'should allow black capture en passant following regular chess rules' do
    		game = Game.create!()
   			white_pawn2 = Pawn.create(game_id: game.id, x_position: 2, y_position: 1, color: "white")
    		black_pawn2 = Pawn.create(game_id: game.id, x_position: 1, y_position: 3, color: "black")
    		white_pawn2.move_to(2, 3)
    		expect(black_pawn2.valid_move?(2, 2)).to be true
  		end

 		it 'should not allow capture en passant if opposing pawn has moved twice' do
    		game = Game.create!()
    		white_pawn3 = Pawn.create(game_id: game.id, x_position: 4, y_position: 4, color: "white")
    		black_pawn3 = Pawn.create(game_id: game.id, x_position: 3, y_position: 6, color: "black")
    		black_pawn3.move_to(3, 5)
    		black_pawn3.move_to(3, 4)
    		expect(white_pawn3.valid_move?(3, 5)).to be false
  		end
  	
	end
end