class CreateProductBundleItems < ActiveRecord::Migration[6.1]
  def change
    create_table :product_bundle_items do |t|
      t.references :product_model, null: false, foreign_key: true
      t.references :product_bundle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
