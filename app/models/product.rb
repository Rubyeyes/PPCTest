class Product < ActiveRecord::Base
	belongs_to :project
	has_many :po_products, dependent: :delete_all
	has_many :pos, through: :po_products
	belongs_to :cost
	has_many :notifications, as: :notifiable, dependent: :delete_all
	has_many :users, through: :project


	mount_uploader :logo_image, ImageUploader
	mount_uploader :patent_image, ImageUploader
	mount_uploader :made_image, ImageUploader

	include PgSearch
		pg_search_scope :search, against: [:product_name, :item_number, :reminder, :Mark, :Package, :Instruction],
		associated_against: {
			project: [:project_name],
			user: :fullname
		},
		using: {
			tsearch: {
				:dictionary => "english",
				any_word: true,
				prefix: true
				}
			}


	def self.text_filter filter
		if filter.present?
			joins(:project).where("user_id = ?", filter)
		else
			all
		end
	end
	def self.text_search query
		if query.present?
			search(query)
		else
			all
		end
	end
	def self.user_filter current_user
		if current_user.role == "factory"
			joins(:project).where("user_id = ?", current_user.id)
		else
			all
		end
	end
	def self.text_sort sort, direction
		if sort.present?
			joins(:project).order("#{sort} #{direction}")
		else
			joins(:project).order('created_at DESC, item_number ASC')
		end		
	end

end
