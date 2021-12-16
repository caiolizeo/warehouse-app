require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    User.create!(email: 'email@teste.com', password: '123456789')

    
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'email@teste.com'
      fill_in 'Senha', with: '123456789'
      click_on 'Entrar'
    end
    

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content('Olá email@teste.com')

  end

  it 'e digita uma senha incorreta' do
    User.create!(email: 'email@teste.com', password: '123456789')

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'email@teste.com'
      fill_in 'Senha', with: '1'
      click_on 'Entrar'
    end
    expect(current_path).to eq new_user_session_path
    expect(page).not_to have_link('Sair')
    expect(page).not_to have_content('Olá email@teste.com')
    expect(page).to have_content('E-mail ou senha inválidos.')
  end

  it 'e digita um email incorreto' do
    User.create!(email: 'email@teste.com', password: '123456789')

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'email@t.com'
      fill_in 'Senha', with: '123456789'
      click_on 'Entrar'
    end

    expect(current_path).to eq new_user_session_path
    expect(page).not_to have_link('Sair')
    expect(page).not_to have_content('Olá email@teste.com')
    expect(page).to have_content('E-mail ou senha inválidos.')
  end

  it 'e não preenche os campos necessários' do
    
    User.create!(email: 'email@teste.com', password: '123456789')

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      click_on 'Entrar'
    end

    expect(current_path).to eq new_user_session_path
    expect(page).not_to have_link('Sair')
    expect(page).not_to have_content('Olá email@teste.com')
    expect(page).to have_content('E-mail ou senha inválidos.')
  end

  it 'e depois faz logout' do
    User.create!(email: 'email@teste.com', password: '123456789')

    
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'email@teste.com'
      fill_in 'Senha', with: '123456789'
      click_on 'Entrar'
    end
    click_on 'Sair'
    
    expect(page).to have_link('Entrar')
    expect(page).to have_content('Logout efetuado com sucesso.')
    expect(page).not_to have_link('Sair')
    expect(page).not_to have_content('Olá email@teste.com')

  end

end