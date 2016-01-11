class RemoveRefProductFromCost < ActiveRecord::Migration
  def change
    remove_reference :costs, :product, index: true, foreign_key: true
  end
end
