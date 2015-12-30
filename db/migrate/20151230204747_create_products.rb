class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :item_number
      t.string :status

      t.timestamps null: false
    end
  end
end
