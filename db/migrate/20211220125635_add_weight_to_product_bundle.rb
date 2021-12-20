class AddWeightToProductBundle < ActiveRecord::Migration[6.1]
  def change
    add_column :product_bundles, :weight, :integer
  end
end
