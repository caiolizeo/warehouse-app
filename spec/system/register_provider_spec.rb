require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'e um visitante não vê o link de cadastro' do
    visit root_path
    expect(page).not_to have_content('Cadastrar novo fornecedor')
  end

  it  'e um visitante não acessa diretamente o formulário' do
    visit new_provider_path

    expect(current_path).to eq new_user_session_path
  end

  it 'e vê um formulário' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user)
    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_content 'Novo fornecedor'
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Telefone'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user)
    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: 'J Presentes'
    fill_in 'Razão social', with: 'J importações LTDA ME'
    fill_in 'CNPJ', with: '21.749.641/0001-13'
    fill_in 'Endereço', with: 'Av Paulista 500'
    fill_in 'Email', with: 'contato@jpresentes.com'
    fill_in 'Telefone', with: '11 99999-9999'
    click_on 'Gravar'

    expect(page).to have_content('Nome fantasia: J Presentes')
    expect(page).to have_content('Razão social: J importações LTDA ME')
    expect(page).to have_content('CNPJ: 21.749.641/0001-13')
    expect(page).to have_content('Endereço: Av Paulista 500')
    expect(page).to have_content('Email: contato@jpresentes.com')
    expect(page).to have_content('Telefone: 11 99999-9999')
    expect(page).to have_content('Fornecedor cadastrado com sucesso!')
  end

  it 'e os campos são obrigatórios' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user)
    visit root_path

    click_on 'Ver todos os fornecedores'
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: ''
    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Email', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
    expect(page).to have_content('Nome fantasia não pode ficar em branco')
    expect(page).to have_content('Razão social não pode ficar em branco')
    expect(page).to have_content('Cnpj não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  it 'e o cnpj deve ser único' do
    Provider.create!(trading_name: 'J Presentes', company_name: 'J importações LTDA ME',
                    cnpj: '21.749.641/0001-13', email: 'contato@jpresentes.com')
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user)
    visit root_path

    click_on 'Ver todos os fornecedores'
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: 'K Presentes'
    fill_in 'Razão social', with: 'K importações LTDA ME'
    fill_in 'CNPJ', with: '21.749.641/0001-13'
    fill_in 'Email', with: 'contato@kpresentes.com'
    click_on 'Gravar'

    expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
    expect(page).to have_content('Cnpj já está em uso')
  end

  it 'e o cnpj deve possuir formato correto' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path

    click_on 'Ver todos os fornecedores'
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: 'K Presentes'
    fill_in 'Razão social', with: 'K importações LTDA ME'
    fill_in 'CNPJ', with: '21749641000113'
    fill_in 'Email', with: 'contato@kpresentes.com'
    click_on 'Gravar'

    expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
    expect(page).to have_content('Cnpj possui formato inválido')
  end
end
