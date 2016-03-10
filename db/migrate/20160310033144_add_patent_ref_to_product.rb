class AddPatentRefToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :patent, index: true, foreign_key: true
  end
end
