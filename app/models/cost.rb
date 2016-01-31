class Cost < ActiveRecord::Base
  belongs_to :project
  has_many :products
  has_many :notifications, as: :notifiable, dependent: :delete_all
  has_one :user, through: :project

  include PgSearch
		pg_search_scope :search, against: [:unitRMB,:toolingRMB,:unitUSD,:toolingUSD, :description],
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
			joins(:project).order("#{sort} #{direction}")
		else
			joins(:project).order(' created_at DESC, project_name ASC')
		end		
	end

end
