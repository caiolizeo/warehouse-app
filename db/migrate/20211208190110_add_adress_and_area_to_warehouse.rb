class AddAdressAndAreaToWarehouse < ActiveRecord::Migration[6.1]
  def change
    add_column :warehouses, :address, :string
    add_column :warehouses, :city, :string
    add_column :warehouses, :state, :string
    add_column :warehouses, :postal_code, :string
    add_column :warehouses, :total_area, :integer
    add_column :warehouses, :useful_area, :integer
  end
end
