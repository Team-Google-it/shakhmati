class GamesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :update, :show, :destroy]

	def promote
		@game = Game.find_by_id(params[:id])
		new_type = params[:type]
		@piece = @game.last_piece_moved
		@piece.update(type: new_type)
	end

	def index
		@games = Game.available
		@game = Game.new
	end

	def new

	end

	def create
		@game = Game.create(game_params)
		@game.update(:white_player_id => current_user.id, :status => "pending")
		@game.assign_first_turn
		pieces = @game.pieces.where(color: "white").all
		pieces.each do |piece|
			piece.update(player_id: @game.white_player_id)
		end

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
			@game.update(:black_player_id => current_user.id, :status => "in_progress")
			pieces = @game.pieces.where(color: "black").all
			pieces.each do |piece|
				piece.update(player_id: @game.black_player_id)
			end
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

				loser = User.find_by(id: @game.black_player_id)
				user = User.find_by(id: @game.white_player_id)

				user_total_games = user.total_games + 1
				loser_total_games = loser.total_games + 1
				wins_update = user.wins + 1
				losses_update = loser.losses + 1

				loser.update(:losses => losses_update, :total_games => loser_total_games)
				user.update(:wins => wins_update, :total_games => user_total_games)
				@game.update(:black_player_id => nil, :status => "completed")

			elsif current_user.id == @game.white_player_id

				loser = User.find_by(id: @game.white_player_id)
				user = User.find_by(id: @game.black_player_id)

				user_total_games = user.total_games + 1
				loser_total_games = loser.total_games + 1
				wins_update = user.wins + 1
				losses_update = loser.losses + 1

				loser.update(:losses => losses_update, :total_games => loser_total_games)
				user.update(:wins => wins_update, :total_games => user_total_games)
				@game.update(:white_player_id => nil, :status => "completed")
			else
				flash[:danger] = "You are not a player of this game!"
			end
		else
			@game.pieces.destroy_all
			@game.destroy
		end
		redirect_to user_path(current_user.id)
	end

	private

	def game_params
		params.require(:game).permit(:name, :white_player_id, :status)
	end

end
