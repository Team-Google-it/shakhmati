class GamesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :update, :show, :destroy]

	def index
		@games = Game.available
		@game = Game.new
		@game.populate_white_pieces
		@game.populate_black_pieces
	end

	def new
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
		@game = Game.find(params[:id])
		white_player = @game.white_player_id
		if current_user.id != white_player
			@game.update_attributes(:black_player_id => current_user.id, :status => "in_progress")
			flash[:notice] = "Joined game: #{@game.name}!"
			redirect_to game_path(@game)
		else
			flash[:notice] = "You are already in this game as the white player!"
			redirect_to game_path(@game)
		end
	end

	def show
		@game = Game.find(params[:id])
	end

	def destroy
		@game = Game.find(params[:id])
		if @game.white_player_id && @game.black_player_id && (current_user.id == @game.white_player_id || current_user.id == @game.black_player_id)
			if current_user.id == @game.black_player_id
				user = User.find_by(id: @game.white_player_id)
				wins_update = user.wins + 1
				user.update_attributes(:wins => wins_update)
				@game.update_attributes(:black_player_id => nil, :status => "completed")
			elsif current_user.id == @game.white_player_id
				user = User.find_by(id: @game.black_player_id)
				wins_update = user.wins + 1
				user.update_attributes(:wins => wins_update)
				@game.update_attributes(:white_player_id => nil, :status => "completed")
			else
				flash[:danger] = "You are not a player of this game!"
			end
		else
			pieces = Piece.where(:game_id == @game.id).all
			pieces.destroy_all
			@game.destroy
		end
		redirect_to user_path(current_user.id)
	end

	private

	def game_params
		params.require(:game).permit(:name, :white_player_id, :status)
	end

end
