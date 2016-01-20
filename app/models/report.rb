class Report < ActiveRecord::Base
	belongs_to :project
  	has_many :notifications, as: :notifiable
  	has_many :products, through: :project
  	has_one :user, through: :project

	include PgSearch
		pg_search_scope :search, against: [:name,:content,:created_at],
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
			joins(:project).order('created_at DESC, user_id DESC, name ASC')
		end		
	end

end
