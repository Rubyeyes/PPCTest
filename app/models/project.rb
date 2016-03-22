class Project < ActiveRecord::Base
	has_many :products
	has_many :tasks, dependent: :destroy
	has_many :costs
	has_many :samples
	has_many :reports
	belongs_to :user
	has_many :notifications, as: :notifiable, dependent: :delete_all
	has_many :pos, through: :products
	has_many :instructions	
	has_many :qcstandards	
	has_many :patent_projects
	has_many :patents, through: :patent_projects

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

	def self.text_sort
		joins(:user).order('status ASC, fullname ASC, project_name ASC')		
	end
end
