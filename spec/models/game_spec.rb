require 'rails_helper'

RSpec.describe Game, type: :model do

	describe "#available" do
		it "finds open games" do
			# Arrange: set up data needed for the test
			white_player = Game.new

			white_player.white_player_id = 11

			white_player.save!

			black_player = Game.new

			black_player.black_player_id = 11

			black_player.save!

			open_game = Game.new

			open_game.save!

			closed_game = Game.new

			closed_game.white_player_id = 10
			closed_game.black_player_id = 10

			closed_game.save!

			# Act: call the method being tested
			return_games = Game.available

			# Assert: use expect() calls to make sure the method did the right thing
			expect(return_games).to contain_exactly(open_game, white_player, black_player)

		end
	end

	describe ".populate_white_pieces" do
		let(:user1) { FactoryBot.create(:user) }
		let(:game) { FactoryBot.create :game, white_player_id: user1.id }

		it 'adds a white pawn at x_position: 0 through 7, y_position: 1' do
			expect(Pawn.exists?(game_id: game.id, x_position: 0, y_position: 1, player_id: game.white_player_id)).to be true
		end

		it 'adds a white rook at x_position: 0 and 7, y_position: 0' do
			expect(Rook.exists?(game_id: game.id, x_position: 0, y_position: 0, player_id: game.white_player_id)).to be true
			expect(Rook.exists?(game_id: game.id, x_position: 7, y_position: 0, player_id: game.white_player_id)).to be true
		end

		it 'adds a white knight at x_position: 1 and 6, y_position: 0' do
			expect(Knight.exists?(game_id: game.id, x_position: 1, y_position: 0, player_id: game.white_player_id)).to be true
			expect(Knight.exists?(game_id: game.id, x_position: 6, y_position: 0, player_id: game.white_player_id)).to be true
		end

		it 'adds a white bishop at x_position: 2 and 5, y_position: 0' do
			expect(Bishop.exists?(game_id: game.id, x_position: 2, y_position: 0, player_id: game.white_player_id)).to be true
			expect(Bishop.exists?(game_id: game.id, x_position: 5, y_position: 0, player_id: game.white_player_id)).to be true
		end

		it 'adds a white queen at x_position: 3, y_position: 0' do
			expect(Queen.exists?(game_id: game.id, x_position: 3, y_position: 0, player_id: game.white_player_id)).to be true
		end

		it 'adds a white king at x_position: 4, y_position: 0' do
			expect(King.exists?(game_id: game.id, x_position: 4, y_position: 0, player_id: game.white_player_id)).to be true
		end
	end

	describe ".populate_black_pieces" do
		let(:user2) { FactoryBot.create(:user) }
		let(:game) { FactoryBot.create :game, black_player_id: user2.id }

		it 'adds a black pawn at x_position: 0 through 7, y_position: 6' do
			expect(Pawn.exists?(game_id: game.id, x_position: (0..7), y_position: 6, player_id: game.black_player_id)).to be true
		end

		it 'adds a black rook at x_position: 0 and 7, y_position: 7' do
			expect(Rook.exists?(game_id: game.id, x_position: 0, y_position: 7, player_id: game.black_player_id)).to be true
			expect(Rook.exists?(game_id: game.id, x_position: 7, y_position: 7, player_id: game.black_player_id)).to be true
		end

		it 'adds a black knight at x_position: 1 and 6, y_position: 7' do
			expect(Knight.exists?(game_id: game.id, x_position: 1, y_position: 7, player_id: game.black_player_id)).to be true
			expect(Knight.exists?(game_id: game.id, x_position: 6, y_position: 7, player_id: game.black_player_id)).to be true
		end

		it 'adds a black bishop at x_position: 2 and 5, y_position: 7' do
			expect(Bishop.exists?(game_id: game.id, x_position: 2, y_position: 7, player_id: game.black_player_id)).to be true
			expect(Bishop.exists?(game_id: game.id, x_position: 5, y_position: 7, player_id: game.black_player_id)).to be true
		end

		it 'adds a black queen at x_position: 3, y_position: 7' do
			expect(Queen.exists?(game_id: game.id, x_position: 3, y_position: 7, player_id: game.black_player_id)).to be true
		end

		it 'adds a black king at x_position: 4, y_position: 7' do
			expect(King.exists?(game_id: game.id, x_position: 4, y_position: 7, player_id: game.black_player_id)).to be true
		end
	end
end
