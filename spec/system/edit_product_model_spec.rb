require 'rails_helper'

describe 'Usuário edita um produto' do
  it 'com sucesso' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')

    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, provider: prov1)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, provider: prov1)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                         weight: 100, provider: prov2)

    visit root_path
    click_on 'Ver todos os produtos'

    within('tr#2') do
      click_on 'Editar'
    end

    fill_in 'Nome', with: 'Boneco Darth Vader'
    fill_in 'Peso', with: '270'
    fill_in 'Altura', with: '55'
    fill_in 'Largura', with: '40'
    fill_in 'Profundidade', with: '20'
    select 'C Modas', from: 'Fornecedor'
    click_on 'Editar'

    expect(page).to have_content('Nome: Boneco Darth Vader')
    expect(page).to have_content('Peso: 270 gramas')
    expect(page).to have_content('Dimensões: 55 x 40 x 20')
    expect(page).to have_content("SKU: #{p2.sku}")
    expect(page).to have_content('Fornecedor: C Modas')
  end

  it 'deixa campos em branco' do
    
  end
end