class Project < ActiveRecord::Base
	has_many :products, dependent: :destroy
	has_many :tasks, dependent: :destroy

	validates :project_name, presence: true
end
