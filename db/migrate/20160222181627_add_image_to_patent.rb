class AddImageToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :image, :string
  end
end
