class PosController < ApplicationController
  load_and_authorize_resource
  def index
    @user = current_user
    @search = Po.text_search(params[:query].to_s)
    @pos = @search.user_filter(@user).text_sort(params[:sort], params[:direction]).page params[:page]
  end

  def new
    @po = Po.new
  end

  def create
    @po = Po.new(po_params)
    
    if @po.save
      redirect_to controller: 'po_products', action: 'new', po_id: @po.id
      flash[:notice] = "PO was successfully updated"
    else
      flash[:alert] = "There was a problem creating PO"
      render :new
    end
  end

  def edit
    @po = Po.find(params[:id])
    @po_products = PoProduct.where po_id: @po.id
    @user = current_user
    if current_user.role == "factory" && @po.user_filter(@user).nil?
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @po = Po.find(params[:id])
    if @po.update(po_params)
      redirect_to new_po_product_path(po_id: @po.id)
      flash[:notice] = "PO was successfully updated"
    else
      flash[:alert] = "There was a problem updating PO"
      render :edit
    end
  end

  def show
    @po = Po.find(params[:id])
    @po_products = PoProduct.where po_id: @po.id
    @user = current_user
    if current_user.role == "factory" && @po.user_filter(@user).nil?
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
    
  end

  def destroy
    @po = Po.find(params[:id])
    @po.destroy
    redirect_to :back, notice: "PO was successfully deleted"
  end

  private

  def po_params
    params.require(:po).permit(:id, :po_number, :date, :quantity)
  end

end
