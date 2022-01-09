require 'securerandom'

class ProductItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :warehouse

  validates :code, length: { is: 20 }, uniqueness: true, presence: true

  before_validation :generate_code

  private

  def generate_code
    code = SecureRandom.alphanumeric(20)    
    self.code = code.upcase!
  end
end
