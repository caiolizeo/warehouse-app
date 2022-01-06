class ProductEntry
  attr_reader(:quantity, :product_model_id, :warehouse_id)

  def initialize(quantity:, product_model_id:, warehouse_id:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
  end

  def process
    w = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)

    ProductItem.transaction do
      quantity.times do
        ProductItem.create!(product_model: pm, warehouse: w)
      end
    end
  end


end