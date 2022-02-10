class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def edit
    @product_model = ProductModel.find(params[:id])
  end
  
  def update
    product_model_params = params.require(:product_model).permit(:name, :weight,
                                                                 :length, :height, :width,
                                                                 :provider_id, :category_id)

    @product_model = ProductModel.find(params[:id])
    @product_model.update(product_model_params)

    if @product_model.save
      redirect_to @product_model
    else
      flash.now[:alert] = 'Não foi possível editar o produto'
      render 'edit'
    end

  end

  def index
    @products = ProductModel.all
  end

  def show
    @product_model = ProductModel.find(params[:id])
    @items = @product_model.product_items.group(:warehouse).count
    @warehouses = Warehouse.all
    @error = nil
  end

  def new
    @product_model = ProductModel.new
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :weight,
                                                                 :length, :height, :width,
                                                                 :provider_id, :category_id)
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto registrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível gravar o produto'
      render 'new'
    end
  end

  def product_entry
    pe = ProductEntry.new(quantity: params[:quantity], warehouse_id: params[:warehouse_id],
      product_model_id: params[:id])

    if pe.process
      redirect_to product_model_path(params[:id]), notice: 'Produtos cadastrados com sucesso!'
    else
      @product_model = ProductModel.find(params[:id])
      @items = @product_model.product_items.group(:warehouse).count
      @warehouses = Warehouse.all

      if !pe.valid_quantity?
        @error = 'Quantidade inválida'
      elsif !pe.valid_category?
        @error = "Este galpão não permite itens da categoria #{ProductModel.find(pe.product_model_id).category.name}"
      end
      flash.now[:alert] = 'Não foi possível dar entrada nos itens'
      render 'show' 
    end
  end

  def enable
    pm = ProductModel.find(params[:id])

    if pm.enabled?
      pm.disabled!
    else
      pm.enabled!
    end

    redirect_to product_models_path
  end

end