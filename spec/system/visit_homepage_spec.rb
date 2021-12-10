require "rails_helper"

describe "Visitor abre a tela inicial" do
  it "e vê a mensagem de boas vindas" do
    visit root_path

    expect(page).to have_css("h1", text: "WareHouse App")
    expect(page).to have_css("h3", text: "Boas vindas ao sistema de gestão de estoques")
  end

  it "e vê os galpões cadastrados" do
    Warehouse.new(name: "Guarulhos", code: "GRU").save
    Warehouse.new(name: "Porto Alegre", code: "POA").save
    Warehouse.new(name: "São Luís", code: "SLZ").save
    Warehouse.new(name: "Vitória", code: "VIX").save

    visit root_path
    expect(page).to have_content("Galpões cadastrados")
    expect(page).to have_content("Guarulhos")
    expect(page).to have_content("GRU")
    expect(page).to have_content("Porto Alegre")
    expect(page).to have_content("POA")
    expect(page).to have_content("São Luís")
    expect(page).to have_content("SLZ")
    expect(page).to have_content("Vitória")
    expect(page).to have_content("VIX")
  end

  it "e não ve todos os detalhes do galpão" do
    Warehouse.create(name: "Maceió", code: "MCZ", description: "Ótimo galpão",
                     address: "Av Fernandes Lima", city: "Maceió",
                     state: "AL", postal_code: "57050-000", total_area: 10000, useful_area: 8000)

    visit root_path

    expect(page).not_to have_content("Ótimo galpão")
    expect(page).not_to have_content("Av Fernandes Lima")
    expect(page).not_to have_content("CEP: 57050-000")
    expect(page).not_to have_content("Área Total: 10000 m2")
    expect(page).not_to have_content("Área Útil: 8000 m2")
    expect(page).not_to have_content("Maceió/AL")

  end
end
