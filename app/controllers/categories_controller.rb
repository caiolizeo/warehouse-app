class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    c_params = params.require(:category).permit(:name)
    @category = Category.new(c_params)

    if @category.save
    redirect_to categories_path, notice: 'Categoria cadastrada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar a categoria'
      render 'new'
    end

  end
  
end