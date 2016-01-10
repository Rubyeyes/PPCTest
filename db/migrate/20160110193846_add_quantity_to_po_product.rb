class AddQuantityToPoProduct < ActiveRecord::Migration
  def change
    add_column :po_products, :quantity, :integer
  end
end
