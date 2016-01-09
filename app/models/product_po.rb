class ProductPo < ActiveRecord::Base
  belongs_to :product
  belongs_to :po
end
