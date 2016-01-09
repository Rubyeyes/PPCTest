class Po < ActiveRecord::Base
	has_and_blongs_to_many :product
end
