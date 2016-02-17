class Product < ActiveRecord::Base
	belongs_to :project
	has_many :po_products, dependent: :delete_all
	has_many :pos, through: :po_products
	belongs_to :cost
	has_many :notifications, as: :notifiable, dependent: :delete_all
	has_many :users, through: :project
	has_many :patents, through: :projects


	mount_uploader :logo_image, ImageUploader
	mount_uploader :patent_image, ImageUploader
	mount_uploader :made_image, ImageUploader

	include PgSearch
		pg_search_scope :search, against: [:product_name, :item_number, :reminder, :Mark, :Package, :Instruction],
		associated_against: {
			project: [:project_name],
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
		if sort.present?
			order("#{sort} #{direction}")
		else
			order('item_number ASC')
		end		
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |product|
				csv << product.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			if Product.find_by(item_number: row["item_number"]).present?
				product = Product.find_by(item_number: row["item_number"])
				product.inventory = row["inventory"].to_i
				product.id = product.id.to_s
			else
				product = Product.new								
				product.inventory = row["inventory"].to_i
				product.item_number = row["item_number"]
				product.id = (Product.last.id + 1).to_s
			end
			product.save!
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
