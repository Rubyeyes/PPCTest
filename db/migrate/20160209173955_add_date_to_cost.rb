class AddDateToCost < ActiveRecord::Migration
  def change
    add_column :costs, :date, :datetime
  end
end
