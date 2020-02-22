class SetDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :losses, :integer, default: 0
    change_column :users, :total_games, :integer, default: 0
  end
end
