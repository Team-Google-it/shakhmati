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
end


