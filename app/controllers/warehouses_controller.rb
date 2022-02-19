class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,
                                            :add_category, :register_category,
                                            :disabled]
  before_action :verify_confirm, only: [:confirm]

  def edit
     @warehouse = Warehouse.find(params[:id])
     @errors = []
  end

  def update
    w_params = params.require(:warehouse).permit(:name, :code, :postal_code, :description,
                                                 :useful_area, :total_area)
                                                     
    @warehouse = Warehouse.find(params[:id])
    response = Faraday.get("https://viacep.com.br/ws/#{w_params[:postal_code]}/json/")
    if response.status != 200
      flash.now[:alert] = 'Não foi possível editar o galpão'
      @errors = @warehouse.errors.full_messages
      return render 'new'
    end
    
    @warehouse.update(w_params)
    address = JSON.parse(response.body)
    @warehouse.address = address['logradouro']
    @warehouse.city = address['localidade']
    @warehouse.state = address['uf']
    
    if @warehouse.save
      redirect_to @warehouse, notice: 'Galpão editado com sucesso!'
    else
      @errors = @warehouse.errors.full_messages
      flash.now[:alert] = 'Não foi possível editar o galpão'
      render 'edit'
    end                                          
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    @items = @warehouse.product_items.group(:product_model).count
    @product_models = ProductModel.where(category: @warehouse.categories, status: :enabled)
    @error = nil
  end

  def new
    @warehouse = Warehouse.new
    @errors = []
  end

  def create
    w_params = params.require(:warehouse).permit(:name, :code, :postal_code, :description,
                                                 :useful_area, :total_area)

    @warehouse = Warehouse.new(w_params)
    
    if @warehouse.valid? == false
      flash.now[:alert] = 'Não foi possível gravar o galpão'
    
      @errors = @warehouse.errors.full_messages
      return render 'new'
    end
    response = Faraday.get("https://viacep.com.br/ws/#{w_params[:postal_code]}/json/")

    if response.status == 400
      flash.now[:alert] = 'Não foi possível gravar o galpão'
      @errors = @warehouse.errors.full_messages
      return render 'new'
    end

    address = JSON.parse(response.body)
    @warehouse.address = address['logradouro']
    @warehouse.city = address['localidade']
    @warehouse.state = address['uf']
    
    if @warehouse.save
      # flash[:notice] = 'Galpão cadastrado com sucesso!'
      redirect_to confirm_warehouse_path(@warehouse.id), notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível gravar o galpão'
      @errors = @warehouse.errors.full_messages
      render 'new'
    end
  end

  def confirm
    @warehouse = Warehouse.find(params[:id])
  end

  def activate
    warehouse = Warehouse.find(params[:id])
    n_params = params.permit(:address_number)
    
    if n_params['address_number'].empty?
      warehouse.number = 's/n'
    elsif
      warehouse.number = n_params['address_number']
    end    
    warehouse.enabled!

    redirect_to warehouse
  end

  def disabled
    @warehouses = Warehouse.disabled
  end

  def product_entry
    pe = ProductEntry.new(quantity: params[:quantity], warehouse_id: params[:id],
      product_model_id: params[:product_model_id])

    if pe.process
      redirect_to warehouse_path(params[:id]), notice: 'Produtos cadastrados com sucesso!'
    else
      @warehouse = Warehouse.find(params[:id])
      @items = @warehouse.product_items.group(:product_model).count
      @product_models = ProductModel.all

      if !pe.valid_quantity?
        @error = 'Quantidade inválida'
      elsif !pe.valid_category?
        @error = "Este galpão não permite itens da categoria #{ProductModel.find(pe.product_model_id).category.name}"
      end

      flash.now[:alert] = 'Não foi possível dar entrada nos itens'
      render 'show'
    end
  end

  def search
    @warehouses = Warehouse.where('name like ? OR code like ? OR city like ?',
      "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
  end

  def add_category
    @error = nil
    @warehouse = Warehouse.find(params[:id])
    @categories = Category.all
  end

  def register_category
    c = CategoryLink.new(warehouse_id: params[:id], category_ids: params[:category_ids])
    if c.process
      redirect_to warehouse_path(params[:id])
    else
      @warehouse = Warehouse.find(params[:id])
      @categories = Category.all
 
      @error = 'Nenhuma categoria selecionada' if params[:category_ids].empty?
      flash.now[:alert] = 'Não foi possível inserir novas categorias'
      render 'add_category'
    end
  end

  private

  def verify_confirm
    if Warehouse.find(params[:id]).enabled?
      redirect_to root_path
    end
  end

end
