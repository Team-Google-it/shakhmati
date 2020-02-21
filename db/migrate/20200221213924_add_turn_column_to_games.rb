class AddTurnColumnToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :turn, :string
  end
end
