class GamesController < ApplicationController
	def index
		@games = Game.available
	end

	def new
	end

	def create
	end

	def show
	end

end
