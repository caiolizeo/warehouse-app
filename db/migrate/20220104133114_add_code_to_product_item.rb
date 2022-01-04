class AddCodeToProductItem < ActiveRecord::Migration[6.1]
  def change
    add_column :product_items, :code, :string
  end
end
