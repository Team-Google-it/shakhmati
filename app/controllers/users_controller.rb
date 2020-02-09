class UsersController < ApplicationController
  def show
    @user_games = Game.where(:white_player_id => current_user.id).or(Game.where(:black_player_id => current_user.id))
  end
  def update

  end
end
