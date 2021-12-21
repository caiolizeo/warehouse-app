require 'rails_helper'

describe 'Usuário edita um Galpão' do
  it 'com sucesso' do
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                     address: 'Av Fernandes Lima', city: 'Maceió',
                     state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    
    visit root_path
    click_on 'Maceió'
    click_on 'Editar galpão'

    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Descrição', with: 'Um galpão'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Área total', with: '5000'
    fill_in 'Área útil', with: '3000'
    click_on 'Editar'

    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão')
    expect(page).to have_content('Av Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36000-000')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content('Galpão editado com sucesso!')
  end

  it 'e tenta apagar todos os atributos' do
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                     address: 'Av Fernandes Lima', city: 'Maceió',
                     state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    visit root_path
    click_on 'Maceió'
    click_on 'Editar galpão'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área total', with: ''
    fill_in 'Área útil', with: ''
    click_on 'Editar'

    expect(page).to have_content('Não foi possível editar o galpão')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('Área total não pode ficar em branco')
    expect(page).to have_content('Área útil não pode ficar em branco')
  end

  it 'e tenta utilizar nome e código cadastrados em outro galpão' do
    Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão em Guarulhos',
                      address: 'Rua x', city: 'Guarulhos', state: 'SP', postal_code: '04200-000',
                      total_area: 5000, useful_area: 3000)
    Warehouse.create!(name: 'Porto Alegre', code: 'POA', description: 'Galpão em POA',
                      address: 'Rua y', city: 'Porto Alegre', state: 'RS', postal_code: '03500-000',
                      total_area: 2000, useful_area: 1000)

    visit root_path
    click_on 'Guarulhos'
    click_on 'Editar galpão'

    fill_in 'Nome', with: 'Porto Alegre'
    fill_in 'Código', with: 'POA'
    click_on 'Editar'

    expect(page).to have_content('Não foi possível editar o galpão')
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('Código já está em uso')
  end
end