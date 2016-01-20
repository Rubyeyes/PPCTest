class HomeController < ApplicationController
  def index
    @products = Product.all
    @tasks = Task.all
    @costs = Cost.all.order(crreated_at: :desc)
  end

  def show
  	@project = Project.find(params[:id])
    @products = Product.all
    @tasks = Task.all.order(created_at: :desc)
  end

end
