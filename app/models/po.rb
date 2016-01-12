class Po < ActiveRecord::Base
	has_many :po_products
	has_many :products, through: :po_products, dependent: :delete_all
	has_many :projects, through: :products

	def self.match_current_user id
		joins(:projects).where("user_id = ?", id).uniq
	end

end
