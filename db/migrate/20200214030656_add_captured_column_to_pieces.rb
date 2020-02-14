class AddCapturedColumnToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :captured, :boolean
  end
end
