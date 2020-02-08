class UsersController < ApplicationController
  def show
    @user_games = Game.where(:white_player_id == current_user.id || :black_playeer_id == current_user.id).all
  end
  def update

  end
end
