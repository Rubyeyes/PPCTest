class AddProjectRefToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :project, index: true, foreign_key: true
  end
end
