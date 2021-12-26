class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @product_bundle = ProductBundle.all
  end

  def show
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
  end

  def new
    @product_bundle = ProductBundle.new
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @product_bundle = ProductBundle.new(bundle_params)
    if @product_bundle.save
      redirect_to @product_bundle
    else
      flash.now[:alert] = 'Não foi possível gravar o kit'
      render 'new'
    end
  end
end
