class ProvidersController < ApplicationController
  def show
    @provider = Provider.find(params[:id])
  end

  def index
    @provider_count = Provider.count
    @providers = Provider.all
  end

  def new
    @provider = Provider.new
  end

  def create
    provider_params = params.require(:provider).permit(:trading_name, :company_name, :cnpj,
                                                       :address, :email, :phone)

    @provider = Provider.new(provider_params)

    if @provider.save
      redirect_to provider_path(@provider.id), notice: 'Fornecedor cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o fornecedor'
      render 'new'
    end
  end
end
