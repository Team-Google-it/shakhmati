class AddTotalGamesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_games, :integer
  end
end
