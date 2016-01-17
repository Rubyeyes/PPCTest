class HomeController < ApplicationController
  def index
    @filter = Project.text_filter(params[:filter].to_s)
    @search = @filter.text_search(params[:query].to_s, current_user.role).text_sort.page params[:page]
    @projects = @search.all
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
