require 'rails_helper'

describe 'Usuário vê a página de produtos' do
  it 'e existem produtos cadastrados' do
      prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')
      prov2 = Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
                               cnpj: '18.021.478/0001-63', address: 'Av Europa 250', 
                               email: 'contato@cconfec.com', phone: '99999-9000')
      c1 = Category.create!(name: 'Outros')
      c2 = Category.create!(name: 'Vestuário')
      p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
                                weight: 300, provider: prov1, category: c1)
      p2 = ProductModel.create!(name: 'Boneco Homem Aranha', height: '50', width: '30', length: '15',
                                weight: 250, provider: prov1, category: c1)
      p3 = ProductModel.create!(name: 'Camiseta Homem de ferro', height: '70', width: '40', length: '1',
                                weight: 100, provider: prov2, category: c2)

      visit root_path
      click_on 'Ver todos os produtos'

      expect(page).to have_content('Caneca Marvel')
      expect(page).to have_content('300g')
      expect(page).to have_content('14 x 10 x 8')
      expect(page).to have_content(p1.sku)
      

      expect(page).to have_content('Boneco Homem Aranha')
      expect(page).to have_content('250g')
      expect(page).to have_content('50 x 30 x 15')
      expect(page).to have_content(p2.sku)
      expect(page).to have_content('A Presentes', count: 2)
      expect(page).to have_content('Outros', count: 2)

      expect(page).to have_content('Camiseta Homem de ferro')
      expect(page).to have_content('100g')
      expect(page).to have_content('70 x 40 x 1')
      expect(page).to have_content(p3.sku)
      expect(page).to have_content('C Modas')
      expect(page).to have_content('Vestuário')

  end
  
  it 'e não existe nenhum produto cadastrado' do

    visit root_path
    click_on 'Ver todos os produtos'

    expect(page).to have_content('Nenhum produto cadastrado.')
  end
end