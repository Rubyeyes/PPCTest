class PoProduct < ActiveRecord::Base
  belongs_to :po
  belongs_to :product
end
