require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do

  it 'com sucesso' do
    Provider.create(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '30258600000115', address: 'Av Paulista 500', 
                    email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                    cnpj: '16719454000157', address: 'Av Europa 250', 
                    email: 'contato@cconfec.com', phone: '99999-9000')

    visit root_path
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '14'
    fill_in 'Código SKU', with: 'CN987654A'
    select 'A Presentes', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content('Modelo de produto registrado com sucesso!')
    expect(page).to have_content('Nome: Caneca Star Wars')
    expect(page).to have_content('Peso: 300 gramas')
    expect(page).to have_content('Dimensões: 12 x 8 x 14')
    expect(page).to have_content('SKU: CN987654A')
    expect(page).to have_content('Fornecedor: A Presentes')
    

  end
end