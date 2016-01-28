class Task < ActiveRecord::Base
	belongs_to :project
	belongs_to :executor, class_name: 'User', foreign_key: 'executor_id'

end
