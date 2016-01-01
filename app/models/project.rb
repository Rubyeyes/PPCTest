class Project < ActiveRecord::Base
	has_many :products
	has_many :tasks

	validates :project_name, presence: true
end
