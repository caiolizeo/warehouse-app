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
end