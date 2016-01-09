class Product < ActiveRecord::Base
	belongs_to :project
	has_and_belongs_to_many :po
end
