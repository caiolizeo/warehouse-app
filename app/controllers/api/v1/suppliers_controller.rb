class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Provider.all
    render json: suppliers.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
    begin
      suppliers = Provider.find(params[:id])
    render json: suppliers.as_json(except: [:created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render status: 404, json: {}
    end
  end
end