class PiecesController < GamesController
  skip_before_action :verify_authenticity_token

  def index

  end

  def edit

  end

  def update
    @piece = Piece.find_by(id: params[:id])
    @game = @piece.game
    if current_user.id == @game.white_player_id
      user_color = "white"
    else
      user_color = "black"
    end
    #if @game.stalemate?(user_color)
    #  flash[:alert] = "The game is in a stalemate"
    #  @game.update_attributes(:status => "in_stalemate")
    #end
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i
    if @piece.move_to(new_x, new_y) == false
      flash.now.alert = 'This move is invalid. Try again.'
      render partial: 'games/update'
    else
      current_game.swap_turn
      render partial: 'games/modal'
    end

  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end

  def current_game
    @game ||= Game.find(params[:id] || params[:game_id])
  end
end
