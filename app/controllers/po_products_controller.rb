class PoProductsController < ApplicationController
  def index
  end

  def new
    @po = Po.find(params[:po_id])
    @po_product = @po.po_products.new
    @po_products = PoProduct.where po_id: @po.id
  end

  def create
    @po_product = PoProduct.new(po_product_params)
    
    if @po_product.save
      redirect_to :back
      flash[:notice] = "Product was successfully added"
    else
      flash[:alert] = "There was a problem adding product"
      render :new
    end
  end

  def edit
  end

  def update
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
    params.require(:po_product).permit(:id, :product_id, :po_id, :quantity)
  end
end