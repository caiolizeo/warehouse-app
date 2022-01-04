require 'rails_helper'

describe 'Usuário edita um produto' do
  it 'e um visitante não consegue editar produto' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    c = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                              weight: 250, provider: prov1, category: c)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c)

    visit root_path
    click_on 'Ver todos os produtos'

    expect(page).not_to have_css("tr##{p1.id}", text: 'Editar')
    expect(page).not_to have_css("tr##{p2.id}", text: 'Editar')
    expect(page).not_to have_css("tr##{p3.id}", text: 'Editar')
  end

  it 'e um visitante não acessa diretamente o formulário do produto' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)

    visit edit_product_model_path(p1.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    c = Category.create!(name: 'Outros')
    c2 = Category.create!(name: 'Brinquedos')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                              weight: 250, provider: prov1, category: c)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c)

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'

    within("tr##{p2.id}") do
      click_on 'Editar'
    end

    fill_in 'Nome', with: 'Boneco Darth Vader'
    fill_in 'Peso', with: '270'
    fill_in 'Altura', with: '55'
    fill_in 'Largura', with: '40'
    fill_in 'Profundidade', with: '20'
    select 'C Modas', from: 'Fornecedor'
    select 'Brinquedos', from: 'Categoria'
    click_on 'Editar'

    expect(page).to have_content('Nome: Boneco Darth Vader')
    expect(page).to have_content('Peso: 270 gramas')
    expect(page).to have_content('Dimensões: 55 x 40 x 20')
    expect(page).to have_content("SKU: #{p2.sku}")
    expect(page).to have_content('Categoria: Brinquedos')
    expect(page).to have_content('Fornecedor: C Modas')
  end

  it 'e deixa campos em branco' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    c = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                              weight: 250, provider: prov1, category: c)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c)

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'

    within("tr##{p2.id}") do
      click_on 'Editar'
    end

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    click_on 'Editar'

    expect(page).to have_content('Não foi possível editar o produto')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('Profundidade não pode ficar em branco')
  end

  it 'e utiliza valores inválidos para peso e dimensões' do
    prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                             cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                             email: 'contato@cconfec.com', phone: '99999-9000')
    c = Category.create!(name: 'Outros')
    p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                              weight: 300, provider: prov1, category: c)
    p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                              weight: 250, provider: prov1, category: c)
    p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                              weight: 100, provider: prov2, category: c)

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'

    within("tr##{p2.id}") do
      click_on 'Editar'
    end

    fill_in 'Peso', with: '-5'
    fill_in 'Altura', with: '0'
    fill_in 'Largura', with: '-7'
    fill_in 'Profundidade', with: '0'
    click_on 'Editar'

    expect(page).to have_content('Não foi possível editar o produto')
    expect(page).to have_content('Peso deve ser maior que 0')
    expect(page).to have_content('Altura deve ser maior que 0')
    expect(page).to have_content('Largura deve ser maior que 0')
    expect(page).to have_content('Profundidade deve ser maior que 0')
  end
end