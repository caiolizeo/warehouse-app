require 'rails_helper'

describe 'Usuário registra um kit' do
  it 'e um visitante não vê o link de cadastro' do
    visit root_path
    expect(page).not_to have_content('Novo produto')
  end

  it  'e um visitante não acessa diretamente o formulário' do
    visit new_product_bundle_path

    expect(current_path).to eq new_user_session_path
  end

  it 'mas não existem produtos cadastrados' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Novo kit'

    expect(page).to have_content('Não é possível cadastrar um novo kit pois não existem produtos cadastrados')
    expect(page).not_to have_css('label', text: 'Caneca Marvel')
    expect(page).not_to have_css('label', text: 'Camiseta Homem de ferro')
    expect(page).not_to have_css('label', text: 'Boneco Homem Aranha')
    expect(page).not_to have_button('Gravar')

  end

  it 'com sucesso' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, provider: p, category: c, status: :enabled)
    ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, provider: p, category: c, status: :enabled)
    ProductModel.create!(name: 'Camiseta Homem de ferro', height: '75', width: '40', length: '1',
                         weight: 100, provider: p, category: c, status: :enabled)
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Novo kit'
    fill_in 'Nome', with: 'Kit Presente Nerd'
    fill_in 'Código SKU', with: 'XVJ81D8S24X95X1GH4E8'

    check 'Caneca Marvel'
    check 'Camiseta Homem de ferro'
    click_on 'Gravar'
               
    expect(page).to have_css('h2', text: 'Kit Presente Nerd')
    expect(page).to have_content('KXVJ81D8S24X95X1GH4E8')

    expect(page).to have_css('td', text: 'Caneca Marvel')
    expect(page).to have_css('td', text: '300g')
    expect(page).to have_css('td', text: '14 x 10 x 8')
    expect(page).to have_css('td', text: 'A Presentes')

    expect(page).to have_css('td', text: 'Camiseta Homem de ferro')
    expect(page).to have_css('td', text: '100g')
    expect(page).to have_css('td', text: '75 x 40 x 1')
    expect(page).to have_css('td', text: 'A Presentes')

    expect(page).to have_content('Peso total: 400g')
    expect(page).not_to have_css('td', text: 'Boneco Homem Aranha')
    
  end

  it 'não seleciona nenhum produto e deixa o código sku em branco' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, provider: p, category: c)
    ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, provider: p, category: c)
    ProductModel.create!(name: 'Camiseta Homem de ferro', height: '75', width: '40', length: '1',
                         weight: 100, provider: p, category: c)
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Novo kit'
    fill_in 'Nome', with: 'Kit Presente Nerd'
    fill_in 'Código SKU', with: ''
    
    click_on 'Gravar'

    expect(page).to have_content('Não foi possível gravar o kit')
    expect(page).to have_content('Produtos não podem ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
    expect(page).to have_css('label', text: 'Caneca Marvel')
    expect(page).to have_css('label', text: 'Camiseta Homem de ferro')
    expect(page).to have_css('label', text: 'Boneco Homem Aranha')
  end

  it 'e tenta cadastrar um código SKU com tamanho inválido' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, provider: p, category: c)
    ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, provider: p, category: c)
    ProductModel.create!(name: 'Camiseta Homem de ferro', height: '75', width: '40', length: '1',
                         weight: 100, provider: p, category: c)
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Novo kit'
    fill_in 'Nome', with: 'Kit Presente Nerd'
    fill_in 'Código SKU', with: 'A'
    
    check 'Caneca Marvel'
    check 'Camiseta Homem de ferro'
    click_on 'Gravar'

    expect(page).to have_content('Não foi possível gravar o kit')
    expect(page).to have_content('SKU não possui o tamanho esperado (20 caracteres)')
    expect(page).to have_css('label', text: 'Caneca Marvel')
    expect(page).to have_css('label', text: 'Camiseta Homem de ferro')
    expect(page).to have_css('label', text: 'Boneco Homem Aranha')
  end
end