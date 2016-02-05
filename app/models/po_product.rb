class PoProduct < ActiveRecord::Base
  belongs_to :po
  belongs_to :product
  has_one :project, through: :product
  has_many :notifications, as: :notifiable, dependent: :delete_all
end
