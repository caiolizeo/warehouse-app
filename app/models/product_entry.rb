class ProductEntry
  attr_reader(:quantity, :product_model_id, :warehouse_id)

  def initialize(quantity:, product_model_id:, warehouse_id:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
  end

  def process
    wh = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)
    
    if valid_category? && valid_quantity?
      ProductItem.transaction do
        quantity.times do
          ProductItem.create!(product_model: pm, warehouse: wh)
        end
      end
      return true
    else
      return false
    end
  end

  def valid_category?
    wh = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)

    if wh.category_ids.include? pm.category_id
      return true
    else
      return false
    end
  end

  def valid_quantity?
    if quantity > 0
      return true
    else
      return false
    end
  end

end