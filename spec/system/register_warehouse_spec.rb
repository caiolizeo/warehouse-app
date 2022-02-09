require 'rails_helper'

describe 'Usuário cadastra um galpão' do

  it 'e um visitante não vê o menu' do

    visit root_path

    expect(page).not_to have_link ('Novo galpão')
  end

  it 'e um visitante não acessa diretamente o formulário' do
    
    visit new_warehouse_path
    
    expect(current_path).to eq new_user_session_path
  end

  it 'e vê formulário' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    login_as(user, :scope => :user)
    
    visit root_path
    click_on 'Novo galpão'

    expect(page).to have_content 'Novo galpão'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área total'
    expect(page).to have_field 'Área útil'

  end

  it 'com sucesso' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Novo galpão'

    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Descrição', with: 'Um galpão'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Área total', with: '5000'
    fill_in 'Área útil', with: '3000'
    click_on 'Gravar'

    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão')
    expect(page).to have_content('Av Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36000-000')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content('Galpão cadastrado com sucesso!')

  end

  it 'e todos os campos são obrigatórios' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Novo galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área total', with: ''
    fill_in 'Área útil', with: ''

    click_on 'Gravar'

    expect(page).not_to have_content('Galpão cadastrado com sucesso!')
    expect(page).to have_content('Não foi possível gravar o galpão')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('Área total não pode ficar em branco')
    expect(page).to have_content('Área útil não pode ficar em branco')
  end

  it 'e o nome e código já estão em uso' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                     address: 'Av Fernandes Lima', city: 'Maceió',
                     state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    
    user = login_as(user, :scope => :user)
    visit root_path
    click_on 'Novo galpão'

    fill_in 'Nome', with: 'Maceió'
    fill_in 'Código', with: 'MCZ'
    fill_in 'Descrição', with: 'Ótimo galpão'
    fill_in 'Endereço', with: 'Av Fernandes Lima'
    fill_in 'Cidade', with: 'Maceió'
    fill_in 'Estado', with: 'AL'
    fill_in 'CEP', with: '57050-000'
    fill_in 'Área total', with: '10000'
    fill_in 'Área útil', with: '8000'
    click_on 'Gravar'

    expect(page).not_to have_content('Galpão cadastrado com sucesso!')
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('Código já está em uso')
  end

  it 'e o CEP possui formato inválido' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user)
    visit root_path
    click_on 'Novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Descrição', with: 'Um galpão'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000000'
    fill_in 'Área total', with: '5000'
    fill_in 'Área útil', with: '3000'
    click_on 'Gravar'

    expect(page).not_to have_content('Galpão cadastrado com sucesso!')
    expect(page).to have_content('CEP possui formato inválido')
  end
end