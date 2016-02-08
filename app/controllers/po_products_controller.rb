class PoProductsController < ApplicationController
  load_and_authorize_resource
  def index
  end

  def new
    @po = Po.find(params[:po_id])
    @po_product = @po.po_products.new
    @po_products = PoProduct.where po_id: @po.id
  end

  def create
    @po_product = PoProduct.new(po_product_params)
    @users = User.notification_recipients(@po_product, current_user, params[:controller])  
    
    if @po_product.save
      # @users.each do |user|
      #   Notification.create_notification(@po_product, "add a product to", current_user.id, user.id, params[:controller])
      # end
      redirect_to :back
      flash[:notice] = "Product was successfully added"
    else
      flash[:alert] = "There was a problem adding product"
      render :new
    end
  end

  def edit
    @po = Po.find(params[:po_id])
    @po_product = PoProduct.find(params[:id])
    @po_products = PoProduct.where po_id: @po.id
    if current_user.role == "factory" && @po_products.joins(:project).where("user_id = ?", @user.id).empty?
      # redirect_to root_path
      # flash[:alert] = "You have no authorization"
      raise Forbidden, "You have no authorization to visit this page" 
    end
  end

  def update
    @po = Po.find(po_product_params[:po_id])
    @po_product = PoProduct.find(params[:id])
    if @po_product.update(po_product_params)
      redirect_to new_po_product_path(po_id: @po.id)
      flash[:notice] = "PO was successfully updated"
    else
      flash[:alert] = "There was a problem updating PO"
      render :edit
    end
  end

  def show
  end

  def destroy
    @po_product = PoProduct.find(params[:id])
    @po_product.destroy
    redirect_to :back, notice: "Product was successfully deleted"
  end

  private

  def po_product_params
    params.require(:po_product).permit(:id, :product_id, :po_id, :quantity, :finish_date)
  end
end
