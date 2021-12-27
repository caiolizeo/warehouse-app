require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'nome é obrigatório' do
    category = Category.new

    result = category.valid?

    expect(result).to eq false
  end

  it 'nome não pode ser duplicado' do
    Category.create!(name: 'Calçados')
    category = Category.new(name: 'Calçados')

    result = category.valid?

    expect(result).to eq false
  end
end
