class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    @errors = []
  end

  def create
    c_params = params.require(:category).permit(:name)
    @category = Category.new(c_params)

    if @category.save
    redirect_to categories_path, notice: 'Categoria cadastrada com sucesso'
    else
      @errors = @category.errors.full_messages
      flash.now[:alert] = 'Não foi possível cadastrar a categoria'
      render 'new'
    end

  end

  def show
    @category = Category.find(params[:id])
    @warehouses = @category.warehouses
  end
  
end