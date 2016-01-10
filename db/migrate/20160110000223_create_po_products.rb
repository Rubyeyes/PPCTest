class CreatePoProducts < ActiveRecord::Migration
  def change
    create_table :po_products do |t|
      t.references :po, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
