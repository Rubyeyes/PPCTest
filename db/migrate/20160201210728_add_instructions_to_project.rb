class AddInstructionsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :instructions, :json
  end
end
