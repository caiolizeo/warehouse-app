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
    @items = @warehouse.product_items.group(:product_model).count
    @product_models = ProductModel.all
    @error = nil
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

  def product_entry
    quantity = params[:quantity].to_i
    w = Warehouse.find(params[:id])
    pm = ProductModel.find(params[:product_model_id])
    if quantity < 1
      @warehouse = Warehouse.find(params[:id])
      @items = @warehouse.product_items.group(:product_model).count
      @product_models = ProductModel.all
      @error = 'Quantidade inválida'
      flash.now[:alert] = 'Não foi possível dar entrada nos itens'
      render 'show'
    else
      quantity.times do
        ProductItem.create(product_model: pm, warehouse: w)
      end
      redirect_to w
    end
  end

  def search
    @warehouses = Warehouse.where('name like ? OR code like ? OR city like ?',
      "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
  end

  def add_category
    @warehouse = Warehouse.find(params[:id])
  end
end
