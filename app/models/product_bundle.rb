class ProductBundle < ApplicationRecord
  validates :product_models, presence: {message: 'não podem ficar em branco'}
  validates :sku, :name, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }, if: :sku_not_empty?

  
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items

  before_save do
    self.sku = "K#{self.sku}"

    w = 0
    self.product_models.each do |p|
      w += p.weight
    end
    self.weight = w
  end

  private 
  def sku_not_empty?
    !self.sku.empty?
  end
end
