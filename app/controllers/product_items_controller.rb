class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :register]

  def new

  end

  def submit
    params.permit(:quantity, :warehouse_id, :product_model_id, :commit, :authenticity_token)
    register_item(params[:quantity], params[:warehouse_id], params[:product_model_id])

  end

  private

  def register_item(quantity, warehouse_id, product_model_id)
    valid_registration = false

    for i in 1..quantity.to_i
      item = ProductItem.create(product_model_id: product_model_id, warehouse_id: warehouse_id)

      break if item.valid? == false 

      if i == quantity.to_i
        valid_registration = true
      end
    end

    if valid_registration == true
      return redirect_to warehouse_path(Warehouse.find(warehouse_id))
    else
      return render 'new'
    end
  end

end