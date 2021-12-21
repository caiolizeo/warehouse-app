require 'rails_helper'

describe 'O visitante vê um fornecedor' do
  it 'e vê todos os dados cadastrados' do
    s = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
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
    provider = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                        email: 'contato@apresentes.com', phone: '99999-9999')
    
    prod1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, sku: 'CM3569SD105W3666SD10', provider: provider)
    prod2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, sku: 'BO236S5D10XC3567SX08', provider: provider)
    
    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on provider.trading_name #é possível utilizar uma variável

    expect(page).to have_css('li', text: 'Nome fantasia: A Presentes')
    expect(page).to have_css('p',  text:'Produtos deste fornecedor:')
    expect(page).to have_css('td', text: 'Caneca Marvel')
    expect(page).to have_css('td', text: '300g')
    expect(page).to have_css('td', text: '14 x 10 x 8')
    expect(page).to have_css('td', text: prod1.sku)
    expect(page).to have_css('td', text: 'Boneco Homem Aranha')
    expect(page).to have_css('td', text: '250g')
    expect(page).to have_css('td', text: '50 x 30 x 15')
    expect(page).to have_css('td', text: prod2.sku)


  end

  it 'e consegue voltar para a página de fornecedores' do
    Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                    email: 'contato@apresentes.com', phone: '99999-9999')

    visit root_path
    click_on 'Ver todos os fornecedores'
    click_on 'A Presentes'
    click_on 'Voltar'

    expect(current_path).to eq providers_path
  end
end
