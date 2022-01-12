require 'rails_helper'

describe 'Usuário vê a página de produtos' do
  it 'e vê todos o produtos cadastrados' do
      prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')
      prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                               cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                               email: 'contato@cconfec.com', phone: '99999-9000')
      c1 = Category.create!(name: 'Outros')
      c2 = Category.create!(name: 'Vestuário')
      p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                weight: 300, provider: prov1, category: c1)
      p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                weight: 250, provider: prov1, category: c1)
      p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                                weight: 100, provider: prov2, category: c2)

      visit root_path
      click_on 'Ver todos os produtos'

      expect(page).to have_content('Caneca Marvel')      
      expect(page).to have_content('Outros', count: 2)

      expect(page).to have_content('Boneco Homem Aranha')

      expect(page).to have_content('Camiseta Homem de ferro')
      expect(page).to have_content('Vestuário')

  end
  
  it 'e não existe nenhum produto cadastrado' do

    visit root_path
    click_on 'Ver todos os produtos'

    expect(page).to have_content('Nenhum produto cadastrado.')
  end

  it 'e vê os detalhes de um produto' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    c1 = Category.create!(name: 'Outros')
    c2 = Category.create!(name: 'Vestuário')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c2)

    visit root_path
    click_on 'Ver todos os produtos'
    click_on 'Caneca Marvel'

    expect(page).to have_content('Caneca Marvel')
    expect(page).to have_content('300 gramas')
    expect(page).to have_content('14 x 10 x 8')
    expect(page).to have_content('A Presentes')
    expect(page).to have_content('Outros')
    expect(page).to have_content(p1.sku)

    expect(page).not_to have_content('Camiseta Homem de ferro')
    expect(page).not_to have_content('100g')
    expect(page).not_to have_content('70 x 40 x 1')
    expect(page).not_to have_content(p3.sku)
    expect(page).not_to have_content('C Modas')
    expect(page).not_to have_content('Vestuário')

  end

  it 'e vê o estoque de um produto' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                weight: 250, provider: prov1, category: c1)
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                           address: 'Av Fernandes Lima', city: 'Maceió', categories: [c1],
                           state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'galpão em sp',
                           address: 'Av paulista', city: 'São Paulo', categories: [c1],
                           state: 'SP', postal_code: '01000-000', total_area: 8000, useful_area: 4500)
    w3 = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', description: 'galpão no rio',
                           address: 'Av Brasil', city: 'Rio de Janeiro', categories: [c1],
                           state: 'RJ', postal_code: '05000-000', total_area: 8300, useful_area: 5000)
       
    ProductEntry.new(quantity: 18, warehouse_id: w1.id, product_model_id: p1.id).process
    ProductEntry.new(quantity: 37, warehouse_id: w2.id, product_model_id: p1.id).process
    ProductEntry.new(quantity: 25, warehouse_id: w3.id, product_model_id: p1.id).process
    ProductEntry.new(quantity: 21, warehouse_id: w3.id, product_model_id: p2.id).process
  
    visit root_path
    click_on 'Ver todos os produtos'
    click_on 'Caneca Marvel'

    expect(page).to have_css('h2', text: 'Galpões com estoque disponível')
    expect(page).to have_css('td', text: 'Maceió')
    expect(page).to have_css('td', text: '18')
    expect(page).to have_css('td', text: 'São Paulo')
    expect(page).to have_css('td', text: '37')
    expect(page).to have_css('td', text: 'Rio de Janeiro', count: 1)
    expect(page).to have_css('td', text: '25')
    expect(page).not_to have_css('td', text: '21')

  end

  it 'e não existem produtos no estoque' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)

    visit root_path
    click_on 'Ver todos os produtos'
    click_on 'Caneca Marvel'

    expect(page).to have_css('h2', text:'Produto fora de estoque')
    expect(page).not_to have_css('th', text: 'Galpão')
    expect(page).not_to have_css('th', text: 'Quantidade')
    
  end

  it 'e acessa a página de um galpão com estoque' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c1 = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c1)
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                           address: 'Av Fernandes Lima', city: 'Maceió', categories: [c1],
                           state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
  
    ProductEntry.new(quantity: 18, warehouse_id: w1.id, product_model_id: p1.id).process
    visit root_path
    click_on 'Ver todos os produtos'
    click_on 'Caneca Marvel'
    click_on 'Maceió'

    expect(page).to have_content('Maceió')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('Ótimo galpão')
    expect(page).to have_content('Av Fernandes Lima')
    expect(page).to have_content('Maceió/AL')
    expect(page).to have_content('CEP: 57050-000')
    expect(page).to have_content('Área Total: 10000 m2')
    expect(page).to have_content('Área Útil: 8000 m2')
  end
end