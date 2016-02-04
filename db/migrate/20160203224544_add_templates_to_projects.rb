class AddTemplatesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :templates, :json
  end
end
