class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    product_models = ProductModel.all
    render json: product_models.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
      product_model = ProductModel.find(params[:id])
      render json: product_model.as_json(except: [:created_at, :updated_at],
                                         methods: [:dimensions],
                                         include: {provider: {except: [:created_at, :updated_at]},
                                                   category: {only: [:name, :id]} }), status: 200
  end

end