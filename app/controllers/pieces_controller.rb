class PiecesController < GamesController
  skip_before_action :verify_authenticity_token

  def index

  end

  def edit

  end

  def update
    @piece = Piece.find_by(id: params[:id])
    @game = @piece.game
    #if @game.stalemate?(user_color)
    #  flash[:alert] = "The game is in a stalemate"
    #  @game.update_attributes(:status => "in_stalemate")
    #end
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i
    if @piece.move_to(new_x, new_y) == false
      if current_user.id == @piece.player_id
        flash.now.alert = 'This move is invalid. Try again.'
      else
        flash.now.alert = 'It is not your turn!'
      end
      render partial: 'games/update'
    else
      if @piece.save
        ActionCable.server.broadcast 'game_channel',
        reload: true
      end
      current_game.swap_turn
      if @game.in_check?
        flash.now.alert = "Check!"
        render partial: 'games/modal'
      elsif @game.checkmate?
        flash.now.alert = "Checkmate!"
        render partial: 'games/modal'
      else
        render partial: 'games/modal'
      end
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
