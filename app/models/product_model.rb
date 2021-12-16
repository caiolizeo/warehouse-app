class ProductModel < ApplicationRecord
  belongs_to :provider
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items

  validates :name, :weight, :height, :length, :width, :sku, presence: true
  validates :weight, :height, :length, :width,  numericality: {greater_than: 0}
  validates :sku, length: { is: 20 }, uniqueness: true

  def dimensions
    "#{height} x #{width} x #{length}" 
  end
end
