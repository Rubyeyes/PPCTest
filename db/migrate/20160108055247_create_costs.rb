class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.float :unitUSD
      t.float :toolingUSD
      t.float :unitRMB
      t.float :toolingRMB
      t.text :description
      t.float :ratio
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
