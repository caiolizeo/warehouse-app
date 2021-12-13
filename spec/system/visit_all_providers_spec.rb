require 'rails_helper'

describe 'O visitante acessa a página com todos os fornecedores' do
  it 'E vê todos os fornecedores cadastrados' do
    Provider.create(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '30258600000115', address: 'Av Paulista 500', 
                    email: 'contato@jpresentes.com', phone: '99999-9999')

    Provider.create(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                    cnpj: '16719454000157', address: 'Av Europa 250', 
                    email: 'contato@cconfec.com', phone: '99999-9000')

    visit root_path
    click_on 'Ver todos os fornecedores'

    expect(page).to have_link('Cadastrar novo fornecedor')
    expect(page).not_to have_content('Nenhum fornecedor cadastrado')
    expect(page).to have_content('Lista de fornecedores')
    expect(page).to have_content('Fornecedores cadastrados: 2')
    expect(page).to have_content('A Presentes')
    expect(page).to have_content('C Modas')
  end

  it 'E não existem fornecedores cadastrados' do
    visit root_path
    click_on 'Ver todos os fornecedores'
    
    expect(page).to have_link('Cadastrar novo fornecedor')
    expect(page).to have_content('Nenhum fornecedor cadastrado')
  end

  it 'E consegue voltar para a página inicial' do
    Provider.create(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
      cnpj: '30258600000115', address: 'Av Paulista 500', 
      email: 'contato@jpresentes.com', phone: '99999-9999')

      visit root_path
      click_on 'Ver todos os fornecedores'
      click_on 'Voltar'
      expect(current_path).to eq root_path
  end
end