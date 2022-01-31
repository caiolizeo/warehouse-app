require 'rails_helper'

describe 'Usuário desativa e ativa um modelo de produto' do
  it 'e não está logado' do
    prov1 = create(:provider)
    c1 = create(:category, name: 'Outros')
    p1 = create(:product_model, name: 'Caneca Marvel', provider: prov1, category: c1)
    p2 = create(:product_model, name: 'Boneco Homem Aranha', provider: prov1, category: c1)


    visit root_path
    click_on 'Ver todos os produtos'

    expect(page).not_to have_css("tr##{p1.id}", text: 'Ativar')
    expect(page).not_to have_css("tr##{p2.id}", text: 'Ativar')
    expect(page).not_to have_css("tr##{p1.id}", text: 'Desativar')
    expect(page).not_to have_css("tr##{p2.id}", text: 'Desativar')
  end

  it 'e desativa com sucesso' do
    user = create(:user)
    prov1 = create(:provider)
    c1 = create(:category, name: 'Outros')
    p1 = create(:product_model, name: 'Caneca Marvel', provider: prov1, category: c1, status: 1)

    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'

    within("tr##{p1.id}") do
      click_on 'Desativar'
    end

    expect(page).to have_css("a", text: 'Ativar')
    expect(page).to have_css("li", text: 'Status: Desativado')
  end

  it 'e ativa com sucesso' do
    user = create(:user)
    prov1 = create(:provider)
    c1 = create(:category, name: 'Outros')
    p1 = create(:product_model, name: 'Caneca Marvel', provider: prov1, category: c1, status: 0)

    login_as(user)
    visit root_path
    click_on 'Ver todos os produtos'

    within("tr##{p1.id}") do
      click_on 'Ativar'
    end

    expect(page).to have_css("a", text: 'Desativar')
    expect(page).to have_css("li", text: 'Status: Ativo')
  end
  

end