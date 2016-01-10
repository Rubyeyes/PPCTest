class RemoveQuantityFromPos < ActiveRecord::Migration
  def change
    remove_column :pos, :quantity, :integer
  end
end
