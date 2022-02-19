require 'rails_helper'

describe 'Usuário edita um Galpão', js: true do
  it 'e um visitante não consegue editar produto' do
    w = Warehouse.create!(name: "Maceió", code: "MCZ", description: "Ótimo galpão",
                          address: "Av Fernandes Lima", city: "Maceió", number: 's/n',
                          state: "AL", postal_code: "57055-000", total_area: 10000, useful_area: 8000, status: :enabled)

    visit root_path                   
    within("div#card-#{w.id}") do
      click_on 'Detalhes'
    end
  
    expect(page).not_to have_link('Editar galpão')
  end

  it 'e um visitante não acessa diretamente o formulário do galpão' do
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                      address: 'Av Fernandes Lima', city: 'Maceió',
                      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    
    visit edit_warehouse_path(w.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    w = Warehouse.create!(name: "Maceió", code: "MCZ", description: "Ótimo galpão",
                          address: "Av Fernandes Lima", city: "Maceió", number: 's/n',
                          state: "AL", postal_code: "57055-000", total_area: 10000, useful_area: 8000, status: :enabled)

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    within("div#card-#{w.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar galpão'

    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Descrição', with: 'Um galpão'
    fill_in 'CEP', with: '36045-120'
    fill_in 'Área total', with: '5000'
    fill_in 'Área útil', with: '3000'
    click_on 'Editar'

    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão')
    expect(page).to have_content('Avenida Barão do Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36045-120')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content('Galpão editado com sucesso!')
  end

  it 'e tenta apagar todos os atributos' do
    w = Warehouse.create!(name: "Maceió", code: "MCZ", description: "Ótimo galpão",
      address: "Av Fernandes Lima", city: "Maceió", number: 's/n',
      state: "AL", postal_code: "57055-000", total_area: 10000, useful_area: 8000, status: :enabled)

    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    within("div#card-#{w.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar galpão'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Área total', with: ''
    fill_in 'Área útil', with: ''
    click_on 'Editar'

    expect(page).to have_content('Não foi possível editar o galpão')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Área total não pode ficar em branco')
    expect(page).to have_content('Área útil não pode ficar em branco')
  end

  it 'e tenta utilizar nome e código cadastrados em outro galpão' do
    w = Warehouse.create!(name: "Maceió", code: "MCZ", description: "Ótimo galpão",
      address: "Av Fernandes Lima", city: "Maceió", number: 's/n',
      state: "AL", postal_code: "57055-000", total_area: 10000, useful_area: 8000, status: :enabled)

    Warehouse.create!(name: 'Porto Alegre', code: 'POA', description: 'Galpão em POA',
                      address: 'Rua y', city: 'Porto Alegre', state: 'RS', postal_code: '03500-000',
                      total_area: 2000, useful_area: 1000)
    user = User.create!(email: 'email@teste.com', password: '123456789')
    
    login_as(user)
    visit root_path
    within("div#card-#{w.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar galpão'

    fill_in 'Nome', with: 'Porto Alegre'
    fill_in 'Código', with: 'POA'
    click_on 'Editar'

    expect(page).to have_content('Não foi possível editar o galpão')
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('Código já está em uso')
  end
end