class CreatePos < ActiveRecord::Migration
  def change
    create_table :pos do |t|
      t.string :po_number
      t.datetime :date
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
