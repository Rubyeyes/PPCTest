class Product < ActiveRecord::Base
	belongs_to :project
	has_many :po_products
	has_many :pos, through: :po_products
	belongs_to :cost
end
