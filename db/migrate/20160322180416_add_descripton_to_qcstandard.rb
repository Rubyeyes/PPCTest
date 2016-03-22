class AddDescriptonToQcstandard < ActiveRecord::Migration
  def change
    add_column :qcstandards, :description, :text
  end
end
