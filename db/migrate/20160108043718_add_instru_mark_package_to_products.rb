class AddInstruMarkPackageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :Instruction, :text
    add_column :products, :Mark, :text
    add_column :products, :Package, :text
  end
end
