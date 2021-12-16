class Provider < ApplicationRecord

  has_many :product_models
  validates :trading_name, :company_name, :cnpj, :email, presence: true
  validates :cnpj, uniqueness: true, format: { with: /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/ ,
                                               message: 'possui formato inválido' }

end
