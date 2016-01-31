class Po < ActiveRecord::Base
	has_many :po_products, dependent: :delete_all
	has_many :products, through: :po_products
	has_many :projects, through: :products
	has_many :users, through: :projects

	include PgSearch
		pg_search_scope :search, against: [:date, :po_number],
		associated_against: {
			po_products: [:quantity],
			products: [:product_name, :item_number, :reminder, :Mark, :Package, :Instruction],
			users: :fullname
		},
		using: {
			tsearch: {
				:dictionary => "english",
				any_word: true,
				prefix: true
				}
			}

	def self.text_sort sort, direction
		if sort.present? && direction.present?
			order("#{sort} #{direction}")
		else
			order('po_number DESC, created_at DESC')
		end		
	end


end
