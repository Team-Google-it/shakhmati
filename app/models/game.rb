class Game < ApplicationRecord
	scope :available, -> { where("white_player_id IS NULL or black_player_id IS NULL")}

end

