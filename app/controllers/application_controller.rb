class ApplicationController < ActionController::Base
  helper_method :find_piece, :draw_piece

  def find_piece(x, y, only_find=nil)
    piece = Piece.find_by(x_position: x, y_position: y, game_id: @game.id)
    if piece
      if only_find == nil
        image = draw_piece(piece.type, piece.color)
        return image
      end
      return piece.id
    end
  end

  def draw_piece(type, color)
    if type == "Rook" && color == "black"
      return "BlackRook.png"
    elsif type == "Knight" && color == "black"
      return "BlackKnight.png"
    elsif type == "Bishop" && color == "black"
      return "BlackBishop.png"
    elsif type == "King" && color == "black"
      return "BlackKing.png"
    elsif type == "Queen" && color == "black"
      return "BlackQueen.png"
    elsif type == "Pawn" && color == "black"
      return "BlackPawn.png"
    elsif type == "Rook" && color == "white"
      return "WhiteRook.png"
    elsif type == "Knight" && color == "white"
      return "WhiteKnight.png"
    elsif type == "Bishop" && color == "white"
      return "WhiteBishop.png"
    elsif type == "King" && color == "white"
      return "WhiteKing.png"
    elsif type == "Queen" && color == "white"
      return "WhiteQueen.png"
    elsif type == "Pawn" && color == "white"
      return "WhitePawn.png"
    end
  end
end
