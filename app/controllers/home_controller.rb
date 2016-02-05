class HomeController < ApplicationController
	def index
		@video = Video.find(1)
	end
end
