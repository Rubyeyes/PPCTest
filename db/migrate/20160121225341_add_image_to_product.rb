class AddImageToProduct < ActiveRecord::Migration
  def change
    add_column :products, :logo_image, :string
    add_column :products, :patent_image, :string
    add_column :products, :made_image, :string
  end
end
