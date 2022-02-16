class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.enabled
    @disabled_warehouses = Warehouse.disabled
  end
end