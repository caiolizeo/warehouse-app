class AddCategoryToProductModel < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_models, :category, null: false, foreign_key: true, default: 0
  end
end
