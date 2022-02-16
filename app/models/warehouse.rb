class Warehouse < ApplicationRecord
  enum status: {disabled: 0, enabled: 1}
  has_many :product_items
  has_many :warehouse_categories
  has_many :categories, through: :warehouse_categories

  validates :name, :code, :description, :postal_code,
            :total_area, :useful_area, presence: true
  validates :name, :code, uniqueness: true

  validates :postal_code, format: { with: /\d{5}\-\d{3}/,
                                    message: 'possui formato inválido' }
end
