class PiecesController < GamesController
  skip_before_action :verify_authenticity_token

  def index

  end

  def edit

  end

  def update
    @piece = Piece.find_by(id: params[:id])
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

    if @piece.move_to(new_x, new_y) == false
      if current_user.id == @piece.player_id
        flash.now.alert = 'This move is invalid. Try again.'
      else
        flash.now.alert = 'It is not your turn!'
      end
      render partial: 'games/update'
    else
      @game.swap_turn
      render partial: 'games/modal'
      # action cable broadcast to channel
      if @piece.save
        ActionCable.server.broadcast 'game_channel',
        reload: true
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
