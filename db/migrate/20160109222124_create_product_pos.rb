class CreateProductPos < ActiveRecord::Migration
  def change
    create_table :product_pos do |t|
      t.references :product, index: true, foreign_key: true
      t.references :po, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
