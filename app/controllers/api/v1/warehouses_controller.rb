class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses.as_json(except: [:address, :created_at, :updated_at]), status: 200
  end
  def show
    begin
      warehouse = Warehouse.find(params[:id])
      render json: warehouse.as_json(except: [:address, :created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render status: 404, json: {}
    end
    
  end
end