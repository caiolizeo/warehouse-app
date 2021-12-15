require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    User.create!(email: 'email@teste.com', password: '123456789')

    
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'email@teste.com'
    fill_in 'Senha', with: '123456789'
    click_on 'Entrar'

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
    expect(page).to have_content('Olá email@teste.com')

  end

end