class GamesController < ApplicationController
	def index
		@games = Game.available
		@game = Game.new(name: "New Game")
		@game.populate_white_pieces
		@game.populate_black_pieces
	end

	def new

	end

	def create
	end

	def show
	end

end
