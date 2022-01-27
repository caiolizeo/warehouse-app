class AddStatusToProductModel < ActiveRecord::Migration[6.1]
  def change
    add_column :product_models, :status, :integer, default: 0
  end
end
