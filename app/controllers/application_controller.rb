class ApplicationController < ActionController::Base
  helper_method :draw_piece

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
