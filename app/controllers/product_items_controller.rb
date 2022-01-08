class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:entry, :process_entry]

  def entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
    @error = nil
  end

  def process_entry
    pe = ProductEntry.new(quantity: params[:quantity], warehouse_id: params[:warehouse_id],
                          product_model_id: params[:product_model_id])
    
    done = pe.process

    if done
      redirect_to warehouse_path(pe.warehouse_id)
    else
      @warehouses = Warehouse.all
      @product_models = ProductModel.all
      @error = 'Quantidade inválida'
      flash.now[:alert] = 'Não foi possível dar entrada nos itens'
      render 'entry'
    end
  end

end