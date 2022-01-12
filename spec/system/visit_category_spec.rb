require 'rails_helper'

describe 'Usuário vê categorias' do
  it 'e vê todas as categorias cadastradas' do
    Category.create!(name: 'Vestuário')
    Category.create!(name: 'Calçados')
    Category.create!(name: 'Brinquedos')
    
    visit root_path
    click_on 'Ver todas as categorias'

    expect(page).to have_css('li', text: 'Vestuário')
    expect(page).to have_css('li', text: 'Calçados')
    expect(page).to have_css('li', text: 'Brinquedos')
  end

  it 'e não existem categorias cadastradas' do
    visit root_path
    click_on 'Ver todas as categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  it 'e vê os produtos de uma categoria' do
    c = Category.create!(name: 'Outros')
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                              weight: 250, provider: prov1, category: c)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c)
         
    visit root_path
    click_on 'Ver todas as categorias'
    click_on 'Outros'

    expect(page).to have_css('h1', text: 'Outros')
    expect(page).to have_css('li', text: 'Caneca Marvel')
    expect(page).to have_css('li', text: 'Boneco Homem Aranha')
    expect(page).to have_css('li', text: 'Camiseta Homem de ferro')
  end

  it 'e vê os galpões de uma categoria' do
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
      address: 'Av Fernandes Lima', city: 'Maceió',
      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'galpão em sp',
      address: 'Av paulista', city: 'São Paulo',
      state: 'SP', postal_code: '01000-000', total_area: 8000, useful_area: 4500)

    c = Category.create!(name: 'Eletrônicos', warehouses:[w1, w2])

    visit root_path
    click_on 'Ver todas as categorias'
    click_on 'Eletrônicos'

    expect(page).to have_css('td', text: 'Maceió')
    expect(page).to have_css('td', text: 'MCZ')
    expect(page).to have_css('td', text: '57050-000')
    expect(page).to have_css('td', text: 'São Paulo')
    expect(page).to have_css('td', text: 'SPX')
    expect(page).to have_css('td', text: '01000-000')
  end

  it 'e uma categoria não possui produtos nem galpões' do
    Category.create!(name: 'Eletrônicos')

    visit root_path
    click_on 'Ver todas as categorias'
    click_on 'Eletrônicos'

    expect(page).to have_content('Nenhum produto cadastrado nessa categoria')
    expect(page).to have_content('Nenhum galpão cadastrado nessa categoria')
  end

  it 'e não vê produtos de outras categorias' do
    c = Category.create!(name: 'Outros')
    c2 = Category.create!(name: 'Vestuário')

    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                              weight: 250, provider: prov1, category: c)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c2)
         
    visit root_path
    click_on 'Ver todas as categorias'
    click_on 'Outros'

    expect(page).to have_css('h1', text: 'Outros')
    expect(page).to have_css('li', text: 'Caneca Marvel')
    expect(page).to have_css('li', text: 'Boneco Homem Aranha')
    expect(page).not_to have_css('li', text: 'Camiseta Homem de ferro')
  end

  it 'e vê os detalhes de um produto através de uma categoria' do
    c = Category.create!(name: 'Outros')
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
         
    visit root_path
    click_on 'Ver todas as categorias'
    click_on 'Outros'
    click_on 'Caneca Marvel'

    expect(current_path).to eq product_model_path(p1.id)
    expect(page).to have_content('Caneca Marvel')
    expect(page).to have_content('300 gramas')
    expect(page).to have_content('14 x 10 x 8')
    expect(page).to have_content(p1.sku)
    expect(page).to have_content('A Presentes')
    expect(page).to have_content('Outros')
  end
end