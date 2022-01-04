class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :register]

  def entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def process_entry
    quantity = params[:quantity].to_i
    w = Warehouse.find(params[:warehouse_id])
    pm = ProductModel.find(params[:product_model_id])
    quantity.times do
      ProductItem.create(product_model: pm, warehouse: w)
    end
    redirect_to w
  end

end