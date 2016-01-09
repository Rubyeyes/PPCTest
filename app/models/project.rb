class Project < ActiveRecord::Base
	has_many :products
	has_many :tasks, dependent: :destroy
	has_many :costs
	has_many :samples
	belongs_to :user

	validates :project_name, presence: true
end
