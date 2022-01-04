require 'rails_helper'

describe 'Usuário da entrada em novos itens' do
  it 'com sucesso' do

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
      cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
      email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)
    p2 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                                weight: 100, provider: prov1, category: c1)
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                          address: 'Av Fernandes Lima', city: 'Maceió',
                          state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
         
                          
    login_as(user)
    visit root_path
    click_on 'Entrada de itens'
    fill_in 'Quantidade', with: 100
    select 'MCZ', from: 'Galpão destino'
    select 'Caneca Marvel', from: 'Produto'
    click_on 'Confirmar'
    
    expect(current_path).to eq warehouse_path(w.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("tr##{p1.id}") do
      expect(page).to have_content('Caneca Marvel')
      expect(page).to have_content('100')
    end
  end

  it 'com sucesso diretamente da página do galpão' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)
    p2 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov1, category: c1)
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                          address: 'Av Fernandes Lima', city: 'Maceió',
                          state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    login_as(user)
    visit root_path
    click_on 'Maceió'
    fill_in 'Quantidade', with: 15
    select 'Caneca Marvel', from: 'Produto'
    click_on 'Confirmar'
    
    expect(current_path).to eq warehouse_path(w.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("tr##{p1.id}") do
      expect(page).to have_content('Caneca Marvel')
      expect(page).to have_content('15')
    end

  end


end