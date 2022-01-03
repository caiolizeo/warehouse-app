require 'securerandom'

class ProductModel < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items

  before_validation do
    if self.sku == nil
      self.sku = generate_sku
    end
  end

  validates :name, :weight, :height, :length, :width, presence: true
  validates :weight, :height, :length, :width,  numericality: {greater_than: 0}
  validates :sku, length: { is: 20 }, uniqueness: true

  def dimensions
    "#{height} x #{width} x #{length}" 
  end

  private

  def generate_sku
    sku = SecureRandom.alphanumeric(20)    
    sku.upcase!
  end
 
end
