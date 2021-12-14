class ProductModelsController < ApplicationController

  def new
    
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :sku, :weight,
                                                                 :length, :height, :width,
                                                                 :provider_id)
    product_model = ProductModel.new(product_model_params)

    puts product_model_params
    if product_model.save
      redirect_to root_path, notice: 'Modelo de produto registrado com sucesso!'
    end
  end
end