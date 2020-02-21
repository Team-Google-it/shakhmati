require 'rails_helper'

RSpec.describe Piece, type: :model do

	describe '#capture' do
	    subject(:capture) { white_rook.capture(2, 2) }
	    let(:user1) { FactoryBot.create(:user) }
	    let(:user2) { FactoryBot.create(:user) }
	    let(:white_rook) { FactoryBot.create(:rook, color: 'white', player_id: user1.id) }
	    let(:white_queen) { FactoryBot.create(:queen, color: 'white', player_id: user1.id) }
	    let(:black_queen) { FactoryBot.create(:queen, color: 'black', player_id: user2.id) }
	    before do
	      	allow(white_rook).to receive(:find_piece).and_return(find_piece)
	    end
	    context 'target is of different colors' do
	      	let(:find_piece) { black_queen } 
	      	it "should capture the target" do
		        capture
		        black_queen.reload
		        expect(black_queen.captured).to eq true
	      	end
	    end
	    context 'target is of the same color' do
	      	let(:find_piece) { white_queen } 
	      	it "should not capture the target" do
		        capture
		        white_queen.reload
		        expect(black_queen.captured).to eq false
	      	end
	    end
	end

	describe '#move_to' do
		subject(:move_to) { piece.move_to(2,2) }
		let(:user) { FactoryBot.create(:user) }
		let(:piece) { FactoryBot.create(:rook, player_id: user.id) }
		before do
			allow(piece).to receive(:valid_move?).and_return(valid_move?)
		end
		context 'when move is valid' do
			let(:valid_move?) { true }
			context 'when move checks opponent' do
				let(:checking?) { true }
				let(:game) { piece.game }
				before do
					allow(piece).to receive(:checking?).and_return(checking?)
				end
				it "status should equal in_check" do
					move_to
					expect(game.status).to eq "in_check"
				end
			end
			# context 'when king is in checkmate' do
			# 	let(:checkmate?) { true }
			# 	let(:game) { piece.game }
			# 	before do
			# 		allow(piece).to receive(:checkmate?).and_return(checkmate?)
			# 	end
			# 	it "status should equal checkmate" do
			# 		move_to
			# 		expect(game.status).to eq "checkmate"
			# 	end
			# end
		end
		context 'when move is invalid' do
			let(:valid_move?) { false }
			it { is_expected.to eq false }
		end
	end

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
			g.assign_first_turn
			p1 = Pawn.create(game_id: g.id, x_position: 2, y_position: 2, color: "white")
			p2 = Pawn.create(game_id: g.id, x_position: 3, y_position: 3, color: "black")

			p1.move_to(3,3)
			p2.reload
			expect(p2.x_position).to eq(nil)
			expect(p1.x_position).to eq(3)
		end

		it "should return false if piece is same color" do
			g = Game.create!()
			g.assign_first_turn
			p1 = Rook.create(game_id: g.id, x_position: 2, y_position: 2, color: "white")
			p2 = Rook.create(game_id: g.id, x_position: 2, y_position: 3, color: "white")

			result = p1.move_to(2,3)
			expect(result).to be false
		end

		it "should change piece location if empty" do
			g = Game.create!()
			g.assign_first_turn
			p = Pawn.create(game_id: g.id, x_position: 2, y_position: 2, color: "white")

			p.move_to(2,3)
			expect(p.y_position).to eq(3)
		end

		it "should allow white capture en passant from the left" do
    		game = Game.create!()
    		game.assign_first_turn
    		game.swap_turn
    		white_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 7, y_position: 4, color: "white")
    		black_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 6, y_position: 6, color: "black")
    		black_pawn.move_to(6, 4)
    		game.swap_turn
    		expect(white_pawn.valid_move?(6, 5)).to be true
  		end

  		it "should allow white capture en passant from the right" do
    		game = Game.create!()
    		game.assign_first_turn
    		game.swap_turn
    		white_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 5, y_position: 4, color: "white")
    		black_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 6, y_position: 6, color: "black")
    		black_pawn.move_to(6, 4)
    		game.swap_turn
    		expect(white_pawn.valid_move?(6, 5)).to be true
  		end

  		it "should allow black capture en passant from the left" do
    		game = Game.create!()
    		game.assign_first_turn
   			white_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 1, y_position: 1, color: "white")
    		black_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 0, y_position: 3, color: "black")
    		white_pawn.move_to(1, 3)
    		game.swap_turn
    		expect(black_pawn.valid_move?(1, 2)).to be true
  		end

  		it "should allow black capture en passant from the right" do
    		game = Game.create!()
    		game.assign_first_turn
   			white_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 1, y_position: 1, color: "white")
    		black_pawn = game.pieces.create(type: Pawn, game_id: game.id, x_position: 0, y_position: 3, color: "black")
    		white_pawn.move_to(1, 3)
    		game.swap_turn
    		expect(black_pawn.valid_move?(1, 2)).to be true
  		end
	end
end
