require 'rails_helper'

describe 'Usuário da entrada em novos itens' do

  context 'Um visitante não consegue dar entrada em produtos' do

    it 'tentando acessar a página de entrada diretamente' do
      visit product_items_entry_path

      expect(current_path).to eq new_user_session_path
    end

    it 'na página de entrada de itens' do
      visit root_path

      expect(page).not_to have_button('Entrada de itens')
    end
    
    it 'na página do galpão' do
      w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                            address: 'Av Fernandes Lima', city: 'Maceió',
                            state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

      visit root_path
      click_on 'Maceió'

      expect(page).not_to have_field('Quantidade')
      expect(page).not_to have_field('Produto')
      expect(page).not_to have_button('Confirmar')
    end

    it 'na página de modelo de produto' do
      prov = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                              cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                              email: 'contato@apresentes.com', phone: '99999-9999')
      c = Category.create!(name: 'Outros')
      p = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                               weight: 300, provider: prov, category: c)
    
      visit root_path
      click_on 'Ver todos os produtos'
      click_on 'Caneca Marvel'

      expect(page).not_to have_field('Quantidade')
      expect(page).not_to have_field('Galpão')
      expect(page).not_to have_button('Confirmar')
    end

  end

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
    fill_in 'Quantidade', with: 30
    select 'MCZ', from: 'Galpão destino'
    select 'Caneca Marvel', from: 'Produto'
    click_on 'Confirmar'
    
    expect(current_path).to eq warehouse_path(w.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("tr##{p1.id}") do
      expect(page).to have_content('Caneca Marvel')
      expect(page).to have_content('30')
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

  it 'com sucesso diretamente da página de modelo de produto' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)

    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                          address: 'Av Fernandes Lima', city: 'Maceió',
                          state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'
    click_on 'Caneca Marvel'
    fill_in 'Quantidade', with: 15
    select 'Maceió', from: 'Galpão'
    click_on 'Confirmar'
    
    expect(current_path).to eq product_model_path(p.id)
    expect(page).to have_css('h2', text: 'Galpões com estoque disponível')
    within("tr##{w.id}") do
      expect(page).to have_content('Maceió')
      expect(page).to have_content('15')
    end
  end

  it 'e deixa a quantidade inválida' do
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
    fill_in 'Quantidade', with: -30
    select 'MCZ', from: 'Galpão destino'
    select 'Caneca Marvel', from: 'Produto'
    click_on 'Confirmar'
    

    expect(page).to have_content('Não foi possível dar entrada nos itens')
    expect(page).to have_content('Quantidade inválida')
   
  end

  it 'e deixa a quantidade inválida na página de galpão' do
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
    click_on 'Confirmar'

    expect(page).to have_content('Não foi possível dar entrada nos itens')
    expect(page).to have_content('Quantidade inválida')

  end

  it 'e deixa a quantidade inválida na página de modelo de produto' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)

    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                          address: 'Av Fernandes Lima', city: 'Maceió',
                          state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'
    click_on 'Caneca Marvel'
    click_on 'Confirmar'
    
    expect(page).to have_content('Não foi possível dar entrada nos itens')
    expect(page).to have_content('Quantidade inválida')
  end

end