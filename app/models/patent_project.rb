class PatentProject < ActiveRecord::Base
  belongs_to :patent
  belongs_to :project
  accepts_nested_attributes_for :patent
end
