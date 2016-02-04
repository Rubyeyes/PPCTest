class RemoveTemplatesInstructionsFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :templates, :json
    remove_column :projects, :instructions, :json
  end
end
