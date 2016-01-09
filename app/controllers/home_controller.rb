class HomeController < ApplicationController
  def index
    if current_user.role == "factory"
      @projects = Project.where(user_id: current_user.id).order(created_at: :desc).page params[:page]
    else
      @projects = Project.all.order(created_at: :desc).page params[:page]
    end
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
