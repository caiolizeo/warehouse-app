class ProductBundleItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :product_bundle
end
