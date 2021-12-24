require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  it 'não pode ser criado sem possuir produtos' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    bundle = ProductBundle.new(name: 'Kit Nerd', sku: 'D5E9D5E8R7S5D6T9H5Y4', 
                                  product_models: [])

    result = bundle.valid?

    expect(result).to eq false
  end

  it 'não pode ser criado com o nome em branco' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
      
    product1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                    weight: 300, provider: p)
    product2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                    weight: 250, provider: p)

    bundle = ProductBundle.new(name: '', sku: 'F5G6R9S5F4T7S58T9K62', 
                                   product_models: [product1, product2])
  
    result = bundle.valid?

    expect(result).to eq false
  end

  it 'não pode ser criado com o sku em branco' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
      
    product1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                    weight: 300, provider: p)
    product2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                    weight: 250, provider: p)

    bundle = ProductBundle.new(name: 'Bundle', sku: '', 
                                   product_models: [product1, product2])
  
    result = bundle.valid?
    
    expect(result).to eq false
  end

  it 'não pode ser criado com um sku que já existe' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')

    product1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                    weight: 300, provider: p)
    product2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                    weight: 250, provider: p)

    b1 = ProductBundle.create!(name: 'B1', sku: 'DKE02OEK49S03LS9DO4I', 
                               product_models: [product1, product2])
    b2 = ProductBundle.new(name: 'B2', sku: 'DKE02OEK49S03LS9DO4I', 
                               product_models: [product1, product2])
  
    result = b2.valid?

    expect(result).to eq false
  end

end
