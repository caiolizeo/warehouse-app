class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items

  before_validation do
    self.sku = "K#{self.sku}"
  end

end
