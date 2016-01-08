class RemoveStatusFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :status, :string
  end
end
