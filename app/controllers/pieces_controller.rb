class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index

  end

  def edit

  end

  def update
    @piece = Piece.find(params[:id])
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
