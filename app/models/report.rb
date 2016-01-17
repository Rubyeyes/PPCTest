class Report < ActiveRecord::Base
	belongs_to :project
  	has_many :notifications, as: :notifiable

	def self.match_current_user id
		joins(:project).where(projects: {id: id})		
	end
end
