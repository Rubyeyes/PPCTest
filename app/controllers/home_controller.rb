class HomeController < ApplicationController
	def index
		@video = Video.find_by(id: 1)
	end
end
