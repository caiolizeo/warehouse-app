class CreateWarehouseCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouse_categories do |t|
      t.references :warehouse, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
