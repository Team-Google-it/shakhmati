class PiecesController < GamesController
  skip_before_action :verify_authenticity_token

  def index

  end

  def edit

  end

  def update
    @piece = Piece.find_by(id: params[:id])
    @game = @piece.game
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i
    if @piece.move_to(new_x, new_y) == false
      flash[:alert] = 'This move is invalid. Try again.'
      render partial: 'games/update'
    else
      render partial: 'games/modal'
    end
    redirect_to :back
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
