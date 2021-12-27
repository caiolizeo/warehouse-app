class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :product_models
end
class Category < ApplicationRecord
  
end