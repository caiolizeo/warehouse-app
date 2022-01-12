class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses.as_json(except: [:address, :created_at, :updated_at],
                                    include: [categories: {except: [:created_at, :updated_at]}]), status: 200
  end

  def show
      warehouse = Warehouse.find(params[:id])
      render json: warehouse.as_json(except: [:address, :created_at, :updated_at],
                                     include: [categories: {except: [:created_at, :updated_at]}]), status: 200
  end

  def create
    w_params = params.permit(:name, :code, :description, :address, :city, 
                             :state, :postal_code, :total_area, :useful_area)
    w = Warehouse.new(w_params)

    if w.save
      render json: w.as_json, status: 201
    else
      render status: 422, json: w.errors.full_messages
    end
  end
end