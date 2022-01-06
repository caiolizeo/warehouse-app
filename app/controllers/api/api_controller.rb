class Api::ApiController < ActionController::API
  def index
    warehouses = Warehouse.all
    render json: warehouses, status: 200
  end
end