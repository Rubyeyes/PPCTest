class HomeController < ApplicationController
  def index
  	@projects = Project.all.order(id: :desc).page params[:page]
    @products = Product.all
  end

  def show
  	@project = Project.find(params[:id])
    @products = Product.all
    @tasks = Task.all
  end
end
