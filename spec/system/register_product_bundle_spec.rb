require 'rails_helper'

describe 'Usuário registra um kit' do
  it 'com sucesso' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')

    ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, sku: 'CM3569SD105W3666SD10', provider: p)
    ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, sku: 'BO236S5D10XC3567SX08', provider: p)
    ProductModel.create!(name: 'Camiseta Homem de ferro', height: '75', width: '40', length: '1',
                         weight: 100, sku: 'CAA81D85344V5V1GH4E8', provider: p)

    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit Presente Nerd'
    fill_in 'Código SKU', with: 'KKJ81D8S24X95X1GH4E8'

    check 'Caneca Marvel'
    check 'Camiseta Homem de ferro'
    click_on 'Gravar'
               
    expect(page).to have_content('Kit Presente Nerd')
    expect(page).to have_content('KKJ81D8S24X95X1GH4E8')
    expect(page).to have_content('Caneca Marvel')
    expect(page).to have_content('Camiseta Homem de ferro')
    expect(page).not_to have_content('Boneco Homem Aranha')
  end
end