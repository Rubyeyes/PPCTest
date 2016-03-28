class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = current_user
    # advance search filter
    filter(Product)
    @products = @data.text_sort(params[:sort], params[:direction]).page(params[:page]).per(20)
    
    respond_to do |format|
      format.html
      format.csv { render text: @data.to_csv}
      format.xls #{ render text: @products.to_csv(col_sep: "\t")}
    end
  end

  def new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @product = Product.new()
  end

  def create
    @product = Product.new(product_params)
    @users = User.notification_recipients(@product, current_user, params[:controller])
   
    if @product.save   
      # @users.each do |user|
      #   Notification.create_notification(@product, "create a product of", current_user.id, user.id, params[:controller])
      # end   
      redirect_to controller: 'products', action: 'show', id: @product.id
      flash[:notice] = "Products was successfully created"
    else
      flash[:alert] = "There was a problem creating product"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    if (current_user.role == "factory") && (@product.project.user.fullname != current_user.fullname)
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @product = Product.find(params[:id])
    @users = User.notification_recipients(@product, current_user, params[:controller])
    if @product.update(product_params)
      # @users.each do |user|
      #   Notification.create_notification(@product, "update the product of", current_user.id, user.id, params[:controller])
      # end
      redirect_to controller: 'products', action: 'show', id: @product.id
      flash[:notice] = "Products was successfully updated"
    else
      flash[:alert] = "There was a problem updating product"
      render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
    if (current_user.role == "factory") && (@product.project.user.fullname != current_user.fullname)
      # redirect_to root_path
      # flash[:alert] = "You have no authorization"
      raise Forbidden, "You have no authorization to visit this page" 
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to :back, notice: "Product was successfully deleted"
  end

  def import
    Product.import(params[:file])
    redirect_to products_path
    flash[:notice] = "Products imported"
  end

  private

  def product_params
    params.require(:product).permit(:id, :product_name, :item_number, :Package, :Mark, :Instruction, :reminder, :project_id, :cost_id, :logo_image, :remote_logo_image_url, :patent_image, :remote_patent_image_url, :made_image, :remote_made_image_url, :patent_id)
  end

end
