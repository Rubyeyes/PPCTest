class AddReceivedToSample < ActiveRecord::Migration
  def change
    add_column :samples, :received, :boolean
  end
end
