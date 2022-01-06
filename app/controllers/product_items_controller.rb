class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :register]

  def entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def process_entry
    pe = ProductEntry.new(quantity: params[:quantity], warehouse_id: params[:warehouse_id],
                          product_model_id: params[:product_model_id])
    
    pe.process

    redirect_to warehouse_path(pe.warehouse_id)
  end

end