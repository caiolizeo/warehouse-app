require 'rails_helper'

describe 'Visitante cadastra um galpão' do
  it 'e vê formulário' do


    visit root_path
    click_on 'Cadastrar novo galpão'

    expect(page).to have_content 'Novo galpão'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área total'
    expect(page).to have_field 'Área útil'

  end

  it 'com sucesso' do

    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Descrição', with: 'Um galpão'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Área total', with: '5000'
    fill_in 'Área útil', with: '3000'
    click_on 'Gravar'

    expect(page).to have_content("Juiz de Fora")
    expect(page).to have_content("JDF")
    expect(page).to have_content("Um galpão")
    expect(page).to have_content("Av Rio Branco")
    expect(page).to have_content("Juiz de Fora/MG")
    expect(page).to have_content("CEP: 36000-000")
    expect(page).to have_content("Área Total: 5000 m2")
    expect(page).to have_content("Área Útil: 3000 m2")
    expect(page).to have_content('Galpão cadastrado com sucesso!')

  end
end