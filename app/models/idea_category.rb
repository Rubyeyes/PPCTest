class IdeaCategory < ActiveRecord::Base
	has_many :ideas, dependent: :delete_all
end
