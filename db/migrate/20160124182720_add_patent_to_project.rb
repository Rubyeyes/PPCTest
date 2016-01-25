class AddPatentToProject < ActiveRecord::Migration
  def change
    add_column :projects, :patent_number, :string
  end
end
