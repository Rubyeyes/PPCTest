class Project < ActiveRecord::Base
	has_many :products
	has_many :tasks
end
