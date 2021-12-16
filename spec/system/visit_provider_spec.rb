require 'rails_helper'

describe 'O visitante vê um fornecedor' do
  it 'e vê todos os dados cadastrados' do
    s = Provider.create(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '30258600000115', address: 'Av Paulista 500',
                    email: 'contato@apresentes.com', phone: '99999-9999')

    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on s.trading_name #é possível utilizar uma variável

    expect(page).to have_content('Nome fantasia: A Presentes')
    expect(page).to have_content('Razão social: A importações LTDA ME')
    expect(page).to have_content("CNPJ: #{s.cnpj}")
    expect(page).to have_content('Endereço: Av Paulista 500')
    expect(page).to have_content('Email: contato@apresentes.com')
    expect(page).to have_content('Telefone: 99999-9999')
  end

  it 'e vê os produtos do fornecedor' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                        cnpj: '30258600000115', address: 'Av Paulista 500',
                        email: 'contato@apresentes.com', phone: '99999-9999')
    
    ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, sku: 'CM3569SD105W3666SD10', provider: p)
    ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, sku: 'BO236S5D10XC3567SX08', provider: p)
    
    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on p.trading_name #é possível utilizar uma variável

    expect(page).to have_css('li', text: 'Nome fantasia: A Presentes')
    expect(page).to have_content('Produtos deste fornecedor:')
    expect(page).to have_content('Caneca Marvel')
    expect(page).to have_content('CM3569SD105W3666SD10')


  end

  it 'e consegue voltar para a página de fornecedores' do
    Provider.create(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '30258600000115', address: 'Av Paulista 500',
                    email: 'contato@apresentes.com', phone: '99999-9999')

    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on 'A Presentes'
    click_on 'Voltar'

    expect(current_path).to eq providers_path
  end
end
