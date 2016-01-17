class PoProduct < ActiveRecord::Base
  belongs_to :po
  belongs_to :product
  has_many :notifications, as: :notifiable
end
