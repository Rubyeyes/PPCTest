class Project < ActiveRecord::Base
	has_many :products
	has_many :tasks, dependent: :destroy
	has_many :costs
	has_many :samples
	has_many :reports
	belongs_to :user
	has_many :notifications, as: :notifiable, dependent: :delete_all
	has_many :pos, through: :products

	validates :project_name, presence: true

	mount_uploader :image, ImageUploader

	include PgSearch
		pg_search_scope :search, against: [:project_name, :description, :user_id],
		associated_against: {
			products: [:product_name, :item_number, :reminder, :Mark, :Package, :Instruction],
			tasks: [:executor, :task],
			costs: [:description],
			samples: [:description],
			reports: [:name, :content],
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
			joins(:user).where("fullname LIKE ?", "#{filter}")
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
			where(user_id: current_user.id)
		else
			all
		end
	end
	def self.text_sort
		joins(:user).order('status ASC, fullname ASC, project_name ASC')		
	end
end
