class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Provider.all
    render json: suppliers.as_json(except: [:created_at, :updated_at],
                                   include: [:product_models]), status: 200
  end

  def show
    suppliers = Provider.find(params[:id])
    render json: suppliers.as_json(except: [:created_at, :updated_at],
                                   include: [product_models:{except: [:created_at, :updated_at, :provider_id, :category_id],
                                   include: [category:{except: [:created_at, :updated_at]}]}]), status: 200
  end

  def create
    s_params = params.permit(:trading_name, :company_name, :cnpj, :address, :email, :phone)
    supplier = Provider.new(s_params)
    
    if supplier.save
      render json: supplier.as_json(except: [:created_at, :updated_at],
                                     include: [product_models:{except: [:created_at, :updated_at, :provider_id, :category_id],
                                     include: [category:{except: [:created_at, :updated_at]}]}]), status: 201
    else
      render json: supplier.errors.full_messages, status: 422
    end
  end
end