class AddDescriptionToWarehouse < ActiveRecord::Migration[6.1]
  def change
    add_column :warehouses, :description, :text
  end
end
