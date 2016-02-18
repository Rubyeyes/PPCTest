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

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			if Product.find_by(item_number: row["item_number"]).present?
				product_id = Product.find_by(item_number: row["item_number"]).id.to_s
				if Po.find_by(po_number: row["po_number"]).present?
					po = Po.find_by(po_number: row["po_number"])
					po.date = row["date"]
					po.save!
					if po.po_products.find_by(product_id: product_id).present?
						po_product = po.po_products.find_by(product_id: product_id)
						po_product.quantity = row["quantity"]
					else
						po_product = PoProduct.new
						po_product.id = (PoProduct.last.id+1).to_s
						po_product.po_id = po.id
						po_product.product_id = product_id
						po_product.quantity  = row["quantity"]
					end
				else
					po = Po.new	
					po.po_number = row["po_number"]
					po.date = row["date"]
					po.save!							
					po_product = PoProduct.new
					po_product.id = (PoProduct.last.id+1).to_s
					po_product.po_id = po.id
					po_product.product_id = product_id
					po_product.quantity = row["quantity"]
				end
				po_product.save!
			end
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::CSV.new(file.path, packed: nil, file_warning: :ignore)
		when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
		when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end
end
