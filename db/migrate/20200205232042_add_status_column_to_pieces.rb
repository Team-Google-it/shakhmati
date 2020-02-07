class AddStatusColumnToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :status, :string
  end
end
