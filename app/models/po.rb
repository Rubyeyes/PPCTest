class Po < ActiveRecord::Base
	has_many :po_products
	has_many :products, through: :po_products, dependent: :delete_all

	# def product_name
	# 	products.try(:product_name)
	# end

	# def product_name=(product_name)
	# 	self.product = Product.find_by_product_name(product_name) if product_name.present?
	# end

end
