class Cost < ActiveRecord::Base
  belongs_to :project
  has_many :products

  def self.match_current_user id
  	joins(:project).where("projects.user_id = ?", id)
  end
end
