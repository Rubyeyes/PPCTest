class Sample < ActiveRecord::Base
	belongs_to :project

	def self.match_current_user id
  	joins(:project).where("projects.user_id = ?", id)
  end
end
