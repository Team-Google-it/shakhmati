class GamesController < ApplicationController
	def index
		@games = Game.available
		@game = Game.create(white_player_id: 25)
		@game.populate_white_pieces
	end

	def new

	end

	def create
	end

	def show
	end

end
