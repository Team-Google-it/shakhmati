class GamesController < ApplicationController

	def index
		@games = Game.available
		@game = Game.new
		@game.populate_white_pieces
		@game.populate_black_pieces
	end

	def new
		@games = Game.available
		@game = Game.new
	end

	def create
		@game = Game.create(game_params)
		@game.update_attributes(:white_player_id => current_user.id, :status => "pending")
		if @game.valid?
			redirect_to game_path(@game)
		else
			return render text: 'invalid game', status: :forbidden
		end
	end

	def update
		@game = Game.find_by(params[:name])
		white_player = @game.white_player_id
		if current_user.id != white_player
			@game.update_attributes(:black_player_id => current_user.id, :status => "in_progress")
			flash[:notice] = "Joined game: #{@game.name}!"
			redirect_to game_path(@game.name)
		else
			flash[:notice] = "You are already in this game as the white player!"
			redirect_to game_path(@game)
		end
	end

	def show
		@games = Game.available
		@game = Game.find(params[:id])
	end

	private

	def game_params
		params.require(:game).permit(:name, :white_player_id, :status)
	end

end
