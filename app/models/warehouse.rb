class Warehouse < ApplicationRecord
  validates :name, :code, :description, :address, :postal_code,
            :city, :state, :total_area, :useful_area,
            presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /\d{5}\-\d{3}/,
                                    message: 'possui formato inválido' }
                          
end
