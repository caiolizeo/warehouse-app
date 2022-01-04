class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def edit
     @warehouse = Warehouse.find(params[:id])
  end

  def update
    w_params = params.require(:warehouse).permit(:name, :code, :address, :state,
                                                 :city, :postal_code, :description,
                                                 :useful_area, :total_area)
    
    @warehouse = Warehouse.find(params[:id])
    @warehouse.update(w_params)
    if @warehouse.save
      redirect_to @warehouse, notice: 'Galpão editado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível editar o galpão'
      render 'edit'
    end                                          
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    @items = find_product_items
    @item_id
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    w_params = params.require(:warehouse).permit(:name, :code, :address, :state,
                                                 :city, :postal_code, :description,
                                                 :useful_area, :total_area)
    @warehouse = Warehouse.new(w_params)
    if @warehouse.save
      # flash[:notice] = 'Galpão cadastrado com sucesso!'
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível gravar o galpão'
      render 'new'
    end
  end

  private

  def find_product_items
    local_items = ProductItem.where(warehouse_id: params[:id])
    names = []

    local_items.each do |item|
      name = ProductModel.find(item.product_model_id).name
      names.push(name)
    end

    return names.tally
  end
end
