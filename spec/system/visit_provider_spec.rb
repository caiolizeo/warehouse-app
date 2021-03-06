require 'rails_helper'

describe 'O visitante vê um fornecedor' do
  it 'e vê todos os dados cadastrados' do
    provider = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                    email: 'contato@apresentes.com', phone: '99999-9999')

    visit root_path

    click_on 'Fornecedores'

    expect(page).to have_content('A Presentes')
    expect(page).to have_content(provider.cnpj)
    expect(page).to have_content('contato@apresentes.com')
    expect(page).to have_content('99999-9999')
  end

  it 'e vê os produtos do fornecedor' do
    provider = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                        email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    prod1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                         weight: 300, sku: 'CM3569SD105W3666SD10', provider: provider, category: c)
    prod2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                         weight: 250, sku: 'BO236S5D10XC3567SX08', provider: provider, category: c)
    
    visit root_path
    click_on 'Fornecedores'
    within("tr#provider-#{provider.id}") do
      click_on 'Detalhes'
    end

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

  it 'e não vê produtos de outros fornecedores' do
    provider1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                                 cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                                 email: 'contato@apresentes.com', phone: '99999-9999')

    provider2 = Provider.create!(trading_name: 'xyz metalúrgica', company_name: 'metalúrgica xyz LTDA',
                                 cnpj: '72.074.830/0001-74', address: 'Av Pres. Wilson 521',
                                 email: 'xyz_met@email.com', phone: '99999-9999')

    provider3 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                                 cnpj: '22.281.398/0001-14', address: 'Av Europa 250', 
                                 email: 'contato@cconfec.com', phone: '99999-9000')
    c = Category.create!(name: 'Outros')
    prod1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                 weight: 300, provider: provider1, category: c)
    prod2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                  weight: 250, provider: provider1, category: c)
    prod3 = ProductModel.create!(name: 'Parafuso philips', height: '8', width: '2', length: '2',
                                 weight: 2, provider: provider2, category: c)                            
    prod4 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                                 weight: 100, provider: provider3, category: c)

    visit root_path
    click_on 'Fornecedores'
    within("tr#provider-#{provider1.id}") do
      click_on 'Detalhes'
    end
    
    expect(page).to have_css('td', text: 'Caneca Marvel')
    expect(page).to have_css('td', text: 'Boneco Homem Aranha')
    expect(page).not_to have_content('Parafuso philips')
    expect(page).not_to have_content('Camiseta Homem de ferro')
  end

  it 'e consegue voltar para a página de fornecedores' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                    cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                    email: 'contato@apresentes.com', phone: '99999-9999')

    visit root_path
    click_on 'Fornecedores'
    within("tr#provider-#{p.id}") do
      click_on 'Detalhes'
    end
    click_on 'Voltar'

    expect(current_path).to eq providers_path
  end
end
