class AddDateToSample < ActiveRecord::Migration
  def change
    add_column :samples, :date, :datetime
  end
end
