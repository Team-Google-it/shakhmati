class Game < ApplicationRecord
	has_many :pieces
	
	scope :available, -> { where("white_player_id IS NULL or black_player_id IS NULL")}

end