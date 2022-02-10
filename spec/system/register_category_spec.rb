require 'rails_helper'

describe 'Usuário cadastra nova categoria' do
  it 'e um visitante não vê o link de cadastro' do
    visit root_path
    
    expect(page).not_to have_content('Cadastrar categoria')
  end

  it 'e um visitante não acessa diretamente o formulário' do
    visit new_category_path

    expect(current_path).to eq new_user_session_path
  end

  it 'e vê o formulário de cadastro' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Nova Categoria'

    expect(page).to have_field('Nome')
    
  end

  it 'com sucesso' do
    user = User.create!(email: 'email@teste.com', password: '123456789')

    login_as(user)
    visit root_path
    click_on 'Nova Categoria'
    fill_in 'Nome', with: 'Calçados'
    click_on 'Gravar'

    expect(page).to have_content('Categoria cadastrada com sucesso')
    expect(page).to have_css('td', text: 'Calçados')
  end

  it 'e deixa nome em branco' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Nova Categoria'
    fill_in 'Nome', with: ''
    click_on 'Gravar'

    expect(page).to have_content('Não foi possível cadastrar a categoria')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'e cadastra um nome duplicado' do
    Category.create!(name: 'Calçados')
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    click_on 'Nova Categoria'
    fill_in 'Nome', with: 'Calçados'
    click_on 'Gravar'

    expect(page).to have_content('Não foi possível cadastrar a categoria')
    expect(page).to have_content('Nome já está em uso')
  end
end