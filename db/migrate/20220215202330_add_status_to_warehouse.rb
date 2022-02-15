class AddStatusToWarehouse < ActiveRecord::Migration[6.1]
  def change
    add_column :warehouses, :status, :integer, default: 0
  end
end
