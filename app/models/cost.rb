class Cost < ActiveRecord::Base
  belongs_to :project
  has_many :products
end
