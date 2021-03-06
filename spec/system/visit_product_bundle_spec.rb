require 'rails_helper'

describe 'Um usuário vê todos os bundles cadastrados' do
  it 'com sucesso' do

    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')               
    product1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                    weight: 300, provider: p, category: c)
    product2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                    weight: 250, provider: p, category: c)
    product3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '75', width: '40', length: '1',
                                    weight: 100, provider: p, category: c)

    ProductBundle.create!(name: 'Kit Nerd', sku: 'D5E9D5E8R7S5D6T9H5Y4', 
                          product_models: [product1, product2, product3])
    ProductBundle.create!(name: 'Kit camiseta e caneca', sku: 'F5G6R9S5F4T7S58T9K62', 
                          product_models: [product1, product3])

    visit root_path
    click_on 'Kits'

    expect(page).to have_css('td', text: 'Kit Nerd')
    expect(page).to have_css('td', text: 'KD5E9D5E8R7S5D6T9H5Y4')
    expect(page).to have_css('td', text: '3')

    expect(page).to have_css('td', text: 'Kit camiseta e caneca')
    expect(page).to have_css('td', text: 'KF5G6R9S5F4T7S58T9K62')
    expect(page).to have_css('td', text: '2')
  end

  it 'mas não existem bundles cadastrados' do
    
    visit root_path
    click_on 'Kits'

    expect(page).to have_content('Nenhum kit cadastrado')
  end
end