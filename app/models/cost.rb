class Cost < ActiveRecord::Base
  belongs_to :project
  has_many :products
  has_many :notifications, as: :notifiable

  def self.match_current_user id
  	joins(:project).where("projects.user_id = ?", id)
  end

end
