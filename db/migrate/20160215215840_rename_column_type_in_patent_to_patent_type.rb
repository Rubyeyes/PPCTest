class RenameColumnTypeInPatentToPatentType < ActiveRecord::Migration
  def change
  	rename_column :patents, :type, :patent_type
  end
end
