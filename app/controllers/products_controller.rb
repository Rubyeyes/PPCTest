class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = Product.all
  end

  def new
    @project = Project.find(params[:project_id_param])
    @product = @project.products.new()
  end

  def create
    @product = Product.new(product_params)
   
    if @product.save      
      redirect_to controller: 'home', action: 'show', id: product_params[:project_id].to_i
      flash[:notice] = "Products was successfully created"
    else
      flash[:alert] = "There was a problem creating product"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to controller: 'home', action: 'show', id: @product.project_id
      flash[:notice] = "Products was successfully updated"
    else
      flash[:alert] = "There was a problem updating product"
      render :edit
    end
  end

  def show
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to :back, notice: "Product was successfully deleted"
  end

  private

  def product_params
    params.require(:product).permit(:id, :product_name, :item_number, :Package, :Mark, :Instruction, :reminder, :project_id, :cost_id)
  end

end
