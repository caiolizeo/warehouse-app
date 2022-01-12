require 'rails_helper'

describe 'Usuário vincula categoria com galpão' do

  it 'visitante não vê o link para vincular categorias com o galpão'

  it 'visitante não acessa a página diretamente'

  it 'com sucesso' do
    user = User.create!(email: 'email@teste.com', password: '123456789')
    c1 = Category.create!(name: 'Vestuário')
    c2 = Category.create!(name: 'Eletrônicos')
    c2 = Category.create!(name: 'Congelados')
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
      address: 'Av Fernandes Lima', city: 'Maceió',
      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    login_as(user)
    visit root_path
    click_on 'Maceió'
    click_on 'Adicionar nova categoria ao galpão'
    check 'Vestuário'
    check 'Eletrônicos'
    click_on 'Confirmar'

    expect(current_path).to eq warehouse_path(w.id)
    within('div#categories') do
      expect(page).to have_css('h2', text: "Categorias")
      expect(page).to have_css('li', text: 'Vestuário')
      expect(page).not_to have_content('Congelados')
    end
  end

  it 'usuário não seleciona nenhuma categoria'

end