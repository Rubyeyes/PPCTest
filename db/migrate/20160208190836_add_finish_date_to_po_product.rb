class AddFinishDateToPoProduct < ActiveRecord::Migration
  def change
    add_column :po_products, :finish_date, :datetime
  end
end
