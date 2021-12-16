require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do

  it 'com sucesso' do
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                     cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                     email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                     cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                     email: 'contato@cconfec.com', phone: '99999-9000')

    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '14'
    fill_in 'Código SKU', with: 'CM3569SD105W3666SD10'
    select 'A Presentes', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Nome: Caneca Star Wars')
    expect(page).to have_content('Peso: 300 gramas')
    expect(page).to have_content('Dimensões: 12 x 8 x 14')
    expect(page).to have_content('SKU: CM3569SD105W3666SD10')
    expect(page).to have_content('Fornecedor: A Presentes')
    

  end

  it 'e deixa campos em branco' do
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                     cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                    email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                     cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                     email: 'contato@cconfec.com', phone: '99999-9000')
    
    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Código SKU', with: ''
    select 'C Modas', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).not_to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Não foi possível gravar o produto')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Profundidade não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')

  end

  it 'e deixa as dimensões e o peso menores que 1' do
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                     cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                     email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                     cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                     email: 'contato@cconfec.com', phone: '99999-9000')

    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: -20
    fill_in 'Altura', with: '0'
    fill_in 'Largura', with: '-8'
    fill_in 'Profundidade', with: '-14'
    fill_in 'Código SKU', with: 'CN987654A'
    select 'A Presentes', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).not_to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Não foi possível gravar o produto')
    expect(page).to have_content('Peso deve ser maior que 0')
    expect(page).to have_content('Altura deve ser maior que 0')
    expect(page).to have_content('Largura deve ser maior que 0')
    expect(page).to have_content('Profundidade deve ser maior que 0')
  end

  it 'e o código SKU ja foi cadastrado' do
    p1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '21.749.641/0001-13', address: 'Av Paulista 500', 
                         email: 'contato@jpresentes.com', phone: '99999-9999')

    p2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                         cnpj: '08.385.207/0001-33', address: 'Av Europa 250', 
                         email: 'contato@cconfec.com', phone: '99999-9000')
    
    ProductModel.create!(name: 'Caneca Star Wars', weight: '300',
                        height: '12', length: '8', width: '10', sku: 'CM3569SD105W3666SD10', provider: p1)
    
    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 250
    fill_in 'Altura', with: '10'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '14'
    fill_in 'Código SKU', with: 'CM3569SD105W3666SD10'
    select 'A Presentes', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).not_to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Não foi possível gravar o produto')
    expect(page).to have_content('SKU já está em uso')
  end
end