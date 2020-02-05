class GamesController < ApplicationController
	def index
		@games = Game.available
		@game = Game.create(name: "New Game")
		@game.populate_white_pieces
		@game.populate_black_pieces
	end

	def new

	end

	def create
	end

	def show
		@game = Game.find_by(params[:id])
	end

end
