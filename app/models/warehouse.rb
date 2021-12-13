class Warehouse < ApplicationRecord
  validates :description, :address,
            :city, :state, :total_area, :useful_area,
            presence: true
  validates :name, :code, uniqueness: true, presence: true
  validates :postal_code, format: { with: /\A\d{5}\-\d{3}\z/,
                                    message: 'possui formato inválido' },
                          presence: true
end
