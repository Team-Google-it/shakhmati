class PiecesController < GamesController
  skip_before_action :verify_authenticity_token

  def index

  end

  def edit

  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game

    pawns = @game.pieces.where(type: "Pawn").all
    pawns.each do |pawn|
      if pawn.y_position == 0 || pawn.y_position == 7
        flash.now.alert = 'Please wait until your opponent has promoted their pawn first.'
        render partial: 'games/update'
        return
      end
    end

    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i

    if (current_user.id == @game.white_player_id && @game.turn == "white") || (current_user.id == @game.black_player_id && @game.turn == "black")
    # if (current_user.id == @game.white_player_id && @game.turn == "white") || (current_user.id == @game.black_player_id && @game.turn == "black")
      if @piece.move_to(new_x, new_y) == false
        if current_user.id == @piece.player_id
          flash.now.alert = 'This move is invalid. Try again.'
          render partial: 'games/modal'
        end
      end
    else
      flash.now.alert = 'It is not your turn!'
      render partial: 'games/update'
    end
    #else
    #  flash.now.alert = 'It is not your turn!'
    #  render partial: 'games/update'
    #end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end

  def current_game
    @game ||= Game.find(params[:id] || params[:game_id])
  end
end
