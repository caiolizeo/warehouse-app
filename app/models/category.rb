class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :product_models
    has_many :warehouse_categories
    has_many :warehouses, through: :warehouse_categories
end