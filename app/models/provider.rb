class Provider < ApplicationRecord

  validates :trading_name, :company_name, :cnpj, :email, presence: true
  validates :cnpj, length: {minimum: 13}, uniqueness: true

end
