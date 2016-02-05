class HomeController < ApplicationController
	def index
		@video = Video.find_by(description: "This is for home page and login page video")
	end
end
