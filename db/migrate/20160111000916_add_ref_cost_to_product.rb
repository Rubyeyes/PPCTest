class AddRefCostToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :cost, index: true, foreign_key: true
  end
end
