require 'rails_helper'

describe 'Usuário vê a página de categorias' do
  
  


  it 'vê os galpões de uma categoria' do
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
      address: 'Av Fernandes Lima', city: 'Maceió',
      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'galpão em sp',
      address: 'Av paulista', city: 'São Paulo',
      state: 'SP', postal_code: '01000-000', total_area: 8000, useful_area: 4500)

    c = Category.create!(name: 'Eletrônicos', warehouses:[w1, w2])

    visit root_path
    click_on 'Categorias'
    click_on 'Eletrônicos'

    expect(page).to have_css('td', text: 'Maceió')
    expect(page).to have_css('td', text: 'MCZ')
    expect(page).to have_css('td', text: '57050-000')
    expect(page).to have_css('td', text: 'São Paulo')
    expect(page).to have_css('td', text: 'SPX')
    expect(page).to have_css('td', text: '01000-000')
  end

end