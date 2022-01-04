require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'e um visitante não vê o link de cadastro' do
    visit root_path
    expect(page).not_to have_content('Cadastrar modelo de produto')
  end

  it  'e um visitante não acessa diretamente o formulário' do
    visit new_product_model_path

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return 'sdgeessxsk333ddolllf'
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                     cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                     email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                     cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                     email: 'contato@cconfec.com', phone: '99999-9000')
    Category.create!(name: 'Acessórios')
    Category.create!(name: 'Vestuário')
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '14'
    select 'A Presentes', from: 'Fornecedor'
    select 'Acessórios', from: 'Categoria'
    click_on 'Gravar'

    p = ProductModel.last
    expect(page).to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Nome: Caneca Star Wars')
    expect(page).to have_content("SKU: #{p.sku}")
    expect(page).to have_content('Peso: 300 gramas')
    expect(page).to have_content('Dimensões: 12 x 8 x 14')
    expect(page).to have_content('Categoria: Acessórios')
    expect(page).to have_content('Fornecedor: A Presentes')
    

  end

  it 'e deixa campos em branco' do
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                     cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                     email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                     cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                     email: 'contato@cconfec.com', phone: '99999-9000')

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    select 'C Modas', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).not_to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Não foi possível gravar o produto')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Profundidade não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')

  end

  it 'e deixa as dimensões e o peso menores que 1' do
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                     cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                     email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                     cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                     email: 'contato@cconfec.com', phone: '99999-9000')
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: -20
    fill_in 'Altura', with: '0'
    fill_in 'Largura', with: '-8'
    fill_in 'Profundidade', with: '-14'
    
    select 'A Presentes', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).not_to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Não foi possível gravar o produto')
    expect(page).to have_content('Peso deve ser maior que 0')
    expect(page).to have_content('Altura deve ser maior que 0')
    expect(page).to have_content('Largura deve ser maior que 0')
    expect(page).to have_content('Profundidade deve ser maior que 0')
  end


end