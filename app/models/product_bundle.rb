class ProductBundle < ApplicationRecord
  validates :product_models, presence: {message: 'não podem ficar em branco'}
  validates :sku, :name, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { message: 'não possui o tamanho esperado (20 caracteres)', is: 21 }, if: :sku_not_empty?

  
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items

  before_validation do
    if sku_not_empty?
      self.sku = "K#{self.sku}"
    end
  end

  after_validation do
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
