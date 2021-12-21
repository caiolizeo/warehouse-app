require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  it 'e vê a mensagem de boas vindas' do
    visit root_path

    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de estoques')
  end

  it 'e vê os galpões cadastrados' do
    Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão em Guarulhos',
                      address: 'Rua x', city: 'Guarulhos', state: 'SP', postal_code: '04200-000',
                      total_area: 5000, useful_area: 3000)
    Warehouse.create!(name: 'Porto Alegre', code: 'POA', description: 'Galpão em POA',
                      address: 'Rua y', city: 'Porto Alegre', state: 'RS', postal_code: '03500-000',
                  total_area: 2000, useful_area: 1000)
    Warehouse.create!(name: 'São Luís', code: 'SLZ', description: 'Galpão em São Luís',
                      address: 'Rua z', city: 'São Luís', state: 'MA', postal_code: '01700-000',
                      total_area: 2500, useful_area: 2000)
    Warehouse.create!(name: 'Vitória', code: 'VIX', description: 'Galpão em Vitória', 
                      address: 'Rua a', city: 'Vitória', state: 'ES', postal_code: '02500-000',
                      total_area: 2700, useful_area: 2300)

    visit root_path
    
    expect(page).to have_content('Galpões cadastrados')
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('POA')
    expect(page).to have_content('São Luís')
    expect(page).to have_content('SLZ')
    expect(page).to have_content('Vitória')
    expect(page).to have_content('VIX')
  end

  it 'e não ve todos os detalhes do galpão' do
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                     address: 'Av Fernandes Lima', city: 'Maceió',
                     state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    visit root_path

    expect(page).not_to have_content('Ótimo galpão')
    expect(page).not_to have_content('Av Fernandes Lima')
    expect(page).not_to have_content('CEP: 57050-000')
    expect(page).not_to have_content('Área Total: 10000 m2')
    expect(page).not_to have_content('Área Útil: 8000 m2')
    expect(page).not_to have_content('Maceió/AL')

  end
end
