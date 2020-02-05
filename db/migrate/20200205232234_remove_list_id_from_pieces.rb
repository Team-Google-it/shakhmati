class RemoveListIdFromPieces < ActiveRecord::Migration[5.2]
  def change
    remove_column :pieces, :list_id, :string
  end
end
