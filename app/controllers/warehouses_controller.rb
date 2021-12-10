class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
  end

  def create
    w_params = params.require(:warehouse).permit(:name, :code, :address, :state,
                                                 :city, :postal_code, :description,
                                                 :useful_area, :total_area)
    w = Warehouse.new(w_params)
    w.save
    # flash[:notice] = 'Galpão cadastrado com sucesso!'
    redirect_to warehouse_path(w.id), notice: 'Galpão cadastrado com sucesso!'
  end
end
