class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,
                                            :add_category, :register_category]

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
    pe = ProductEntry.new(quantity: params[:quantity], warehouse_id: params[:id],
      product_model_id: params[:product_model_id])

    if pe.process
      redirect_to warehouse_path(params[:id]), notice: 'Produtos cadastrados com sucesso!'
    else
      @warehouse = Warehouse.find(params[:id])
      @items = @warehouse.product_items.group(:product_model).count
      @product_models = ProductModel.all

      if !pe.valid_quantity?
        @error = 'Quantidade inválida'
      elsif !pe.valid_category?
        @error = "Este galpão não permite itens da categoria #{ProductModel.find(pe.product_model_id).category.name}"
      end

      flash.now[:alert] = 'Não foi possível dar entrada nos itens'
      render 'show'
    end
  end

  def search
    @warehouses = Warehouse.where('name like ? OR code like ? OR city like ?',
      "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
  end

  def add_category
    @error = nil
    @warehouse = Warehouse.find(params[:id])
    @categories = Category.all
  end

  def register_category
    c = CategoryLink.new(warehouse_id: params[:id], category_ids: params[:category_ids])
    if c.process
      redirect_to warehouse_path(params[:id])
    else
      @warehouse = Warehouse.find(params[:id])
      @categories = Category.all
 
      @error = 'Nenhuma categoria selecionada' if params[:category_ids].empty?
      flash.now[:alert] = 'Não foi possível inserir novas categorias'
      render 'add_category'
    end
  end
end
