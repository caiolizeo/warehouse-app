class CategoryLink
  attr_reader(:warehouse_id, :category_ids)

  def initialize(warehouse_id:, category_ids:)
    @warehouse_id = warehouse_id
    @category_ids = category_ids
  end

  def process
    warehouse = Warehouse.find(@warehouse_id)
    @category_ids.delete('')
    w_ids = warehouse.category_ids

    @category_ids.each do |id|
      w_ids << id unless w_ids.include? id.to_i
    end

    if w_ids != Warehouse.find(@warehouse_id).category_ids
      warehouse.update(category_ids: w_ids)
      warehouse.save
      return true
    else
      return false
    end
  end

end