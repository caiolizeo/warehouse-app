require 'rails_helper'

describe 'Visitante cadastra um fornecedor' do
  it 'e vê um formulário' do
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_content 'Novo fornecedor'
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Telefone'
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: 'J Presentes'
    fill_in 'Razão social', with: 'J importações LTDA ME'
    fill_in 'CNPJ', with: '30258600000115'
    fill_in 'Endereço', with: 'Av Paulista 500'
    fill_in 'Email', with: 'contato@jpresentes.com'
    fill_in 'Telefone', with: '11 99999-9999'
    click_on 'Gravar'

    expect(page).to have_content('Nome fantasia: J Presentes')
    expect(page).to have_content('Razão social: J importações LTDA ME')
    expect(page).to have_content('CNPJ: 30258600000115')
    expect(page).to have_content('Endereço: Av Paulista 500')
    expect(page).to have_content('Email: contato@jpresentes.com')
    expect(page).to have_content('Telefone: 11 99999-9999')
    expect(page).to have_content('Fornecedor cadastrado com sucesso!')
  end

  it 'e os campos são obrigatórios' do
    visit root_path
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
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  it 'e o cnpj deve ser único' do
    Provider.create(trading_name: 'J Presentes', company_name: 'J importações LTDA ME',
                    cnpj: '30258600000115', email: 'contato@jpresentes.com')

    visit root_path
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: 'K Presentes'
    fill_in 'Razão social', with: 'K importações LTDA ME'
    fill_in 'CNPJ', with: '30258600000115'
    fill_in 'Email', with: 'contato@kpresentes.com'
    click_on 'Gravar'

    expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
    expect(page).to have_content('CNPJ deve ser único')
  end

  it 'o cnpj deve possuir 13 digitos' do
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome fantasia', with: 'K Presentes'
    fill_in 'Razão social', with: 'K importações LTDA ME'
    fill_in 'CNPJ', with: '302586000001'
    fill_in 'Email', with: 'contato@kpresentes.com'
    click_on 'Gravar'

    expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Não foi possível cadastrar o fornecedor')
    expect(page).to have_content('CNPJ deve possuir 13 digitos')
  end
end
