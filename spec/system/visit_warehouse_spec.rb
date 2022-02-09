require 'rails_helper'

describe 'Visitante vê um galpão' do
  it 'e vê todos os dados cadastrados' do
    # Arrange -> Preparar db
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                     address: 'Av Fernandes Lima', city: 'Maceió',
                     state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    # Act -> Agir / Executar algo
    visit root_path
    within("div#card-#{w.id}") do
      click_on 'Detalhes'
    end

    # Assert -> Validar/Esperar que algo aconteça
    expect(page).to have_content('Maceió')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('Ótimo galpão')
    expect(page).to have_content('Av Fernandes Lima')
    expect(page).to have_content('Maceió/AL')
    expect(page).to have_content('CEP: 57050-000')
    expect(page).to have_content('Área Total: 10000 m2')
    expect(page).to have_content('Área Útil: 8000 m2')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'e consegue voltar para a tela inicial' do
    # Arrange -> Preparar db
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                     address: 'Av Fernandes Lima', city: 'Maceió',
                     state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    # Act -> Agir / Executar algo
    visit root_path
    within("div#card-#{w.id}") do
      click_on 'Detalhes'
    end
    click_on 'Voltar'

    # Assert -> Validar/Esperar que algo aconteça
    expect(current_path).to eq root_path
  end
end
