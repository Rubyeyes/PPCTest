class AddReportToReport < ActiveRecord::Migration
  def change
    add_column :reports, :report, :string
  end
end
