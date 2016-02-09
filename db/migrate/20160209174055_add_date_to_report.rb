class AddDateToReport < ActiveRecord::Migration
  def change
    add_column :reports, :date, :datetime
  end
end
