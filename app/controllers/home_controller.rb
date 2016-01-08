class HomeController < ApplicationController
  def index
  	@projects = Project.all.order(id: :desc).page params[:page]
    @products = Product.all
    @tasks = Task.all
  end

  def show
  	@project = Project.find(params[:id])
    @products = Product.all
    @tasks = Task.all.order(created_at: :desc)
  end
end
