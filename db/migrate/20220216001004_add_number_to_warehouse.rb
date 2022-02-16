class AddNumberToWarehouse < ActiveRecord::Migration[6.1]
  def change
    add_column :warehouses, :number, :string
  end
end
