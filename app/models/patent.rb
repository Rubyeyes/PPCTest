class Patent < ActiveRecord::Base
	has_many :patent_projects, dependent: :delete_all
	has_many :projects, through: :patent_projects
	has_many :products, through: :projects	
  accepts_nested_attributes_for :patent_projects, allow_destroy: true


  mount_uploader :certificate, CertificateUploader

  include PgSearch
		pg_search_scope :search, against: [:name, :type, :docket_number, :status, :patent_number, :issue_date, :filling_date],
		associated_against: {
			project: [:project_name],
			products: [:product_name, :item_number, :reminder, :Mark, :Package, :Instruction],
			user: :fullname
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
			joins(:projects).order("#{sort} #{direction}")
		else
			joins(:projects).order("docket_number DESC")
		end		
	end

end
