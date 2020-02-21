class AddLossesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :losses, :integer
  end
end
