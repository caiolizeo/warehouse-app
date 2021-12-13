require "rails_helper"

describe "O visitante vê um fornecedor" do
  it "e vê todos os dados cadastrados" do
    Provider.create(trading_name: "A Presentes", company_name: "A importações LTDA ME",
                    cnpj: "30258600000115", address: "Av Paulista 500",
                    email: "contato@apresentes.com", phone: "99999-9999")

    visit root_path
    click_on "A Presentes"

    expect(page).to have_content("Nome fantasia: A Presentes")
    expect(page).to have_content("Razão social: A importações LTDA ME")
    expect(page).to have_content("CNPJ: 30258600000115")
    expect(page).to have_content("Endereço: Av Paulista 500")
    expect(page).to have_content("Email: contato@apresentes.com")
    expect(page).to have_content("Telefone: 99999-9999")
  end

  it "e consegue voltar para a tela inicial" do
    Provider.create(trading_name: "A Presentes", company_name: "A importações LTDA ME",
                    cnpj: "30258600000115", address: "Av Paulista 500",
                    email: "contato@apresentes.com", phone: "99999-9999")

    visit root_path
    click_on "Voltar"

    expect(current_path).to eq root_path
  end
end
