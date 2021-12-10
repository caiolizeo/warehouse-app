class Warehouse < ApplicationRecord
    validates :name, :code, :address, presence: true
end
