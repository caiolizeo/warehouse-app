class ProductModel < ApplicationRecord
  belongs_to :provider

  validates :name, presence: true

  def dimensions
    "#{height} x #{width} x #{length}" 
  end
end
