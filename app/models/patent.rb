class Patent < ActiveRecord::Base
	has_many :patent_projects, dependent: :delete_all
	has_many :projects, through: :patent_projects
	has_many :products, through: :projects	
  accepts_nested_attributes_for :patent_projects, allow_destroy: true


  mount_uploader :certificate, CertificateUploader

  include PgSearch
		pg_search_scope :search, against: [:name, :patent_type, :docket_number, :status, :patent_number, :issue_date, :filling_date],
		associated_against: {
			projects: [:project_name],
			products: [:product_name, :item_number, :reminder, :Mark, :Package, :Instruction],
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
			order("docket_number DESC")
		end		
	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			if Patent.find_by(name: row["name"]).present?
				patent = Patent.find_by(name: row["name"])
				patent.attributes = row.to_hash
			else
				patent = Patent.new
				patent.attributes = row.to_hash
				patent.id = (Patent.last.id + 1).to_s
			end
			patent.save!
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
