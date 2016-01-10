class RemoveQuantityFromPo < ActiveRecord::Migration
  def change
  	remove_column :pos, :quantity, :integer
  end
end
