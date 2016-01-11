class AddProductRefToCost < ActiveRecord::Migration
  def change
    add_reference :costs, :product, index: true, foreign_key: true
  end
end
