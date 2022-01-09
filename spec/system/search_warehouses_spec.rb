require 'rails_helper'

describe 'Usuário busca um galpão' do
  it 'e encontra um galpão' do
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
      address: 'Av Fernandes Lima', city: 'Maceió',
      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'Galpão em sp',
      address: 'Av Paulista', city: 'São Paulo',
      state: 'SP', postal_code: '01050-000', total_area: 20000, useful_area: 15000)
    
    visit root_path
    fill_in 'Buscar galpão', with: 'Mac'
    click_on 'Pesquisar'

    expect(page).to have_css('td', text: 'Maceió', count: 2)
    expect(page).to have_css('td', text: 'MCZ')
    

    expect(page).not_to have_content('São Paulo')
    expect(page).not_to have_content('SPX')
  end

  it 'e encontra galpões com caracteres em comum' do
    Warehouse.create!(name: 'São Caetano', code: 'SCS', description: 'Ótimo galpão',
      address: 'Av Goiás', city: 'São Caetano do Sul',
      state: 'SP', postal_code: '27000-000', total_area: 8000, useful_area: 5000)
    Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'Galpão em sp',
      address: 'Av Paulista', city: 'São Paulo',
      state: 'SP', postal_code: '01050-000', total_area: 20000, useful_area: 15000)
     
    visit root_path
    fill_in 'Buscar galpão', with: 'São'
    click_on 'Pesquisar'

    expect(page).to have_content('São Caetano')
    expect(page).to have_content('São Paulo')  
  end

  it 'e não encontra nenhum galpão' do

    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
      address: 'Av Fernandes Lima', city: 'Maceió',
      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    visit root_path
    fill_in 'Buscar galpão', with: 'São'
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhum galpão encontrado')
    

  end
end