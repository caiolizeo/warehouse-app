# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'email@teste.com', password: '123456')

Warehouse.create!(name: "Maceió", code: "MCZ", description: "Ótimo galpão",
                  address: "Av Fernandes Lima", city: "Maceió",
                  state: "AL", postal_code: "57055-000", total_area: 10000, useful_area: 8000)
Warehouse.create!(name: "São Paulo", code: "SPX", description: "galpão em sp",
                  address: "Av paulista", city: "São Paulo",
                  state: "SP", postal_code: "01311-200", total_area: 8000, useful_area: 4500)

pr1 = Provider.create!(trading_name: "A Presentes", company_name: "A importações LTDA ME",
                       cnpj: "21.749.641/0001-13", address: "Av Paulista 500",
                       email: "contato@jpresentes.com", phone: "99999-9999")

pr2 = Provider.create!(trading_name: "C Modas", company_name: "C Confecções LTDA",
                       cnpj: "08.385.207/0001-33", address: "Av Europa 250",
                       email: "contato@cconfec.com", phone: "99999-9000")

pr3 = Provider.create!(trading_name: "Mercados X", company_name: "SuperMercados X",
                       cnpj: "52.874.953/0001-82", address: "Av Paulista 500",
                       email: "contato@xmerc.com", phone: "99999-5555")

c1 = Category.create!(name: "Vestuário")
c2 = Category.create!(name: "Eletrônicos")
c3 = Category.create!(name: "Refrigerados/Congelados")

product1 = ProductModel.create!(name: "SmartWatch", height: "14", width: "10", length: "8",
                                weight: 300, provider: pr1, category: c2)
product2 = ProductModel.create!(name: "Nuggets Sadia 200g", height: "50", width: "30", length: "15",
                                weight: 250, provider: pr3, category: c3)
product3 = ProductModel.create!(name: "Coca-Cola 2l", height: "3", width: "10", length: "10",
                                weight: 205, provider: pr3, category: c3)
product4 = ProductModel.create!(name: "Camiseta Homem de ferro", height: "75", width: "40", length: "1",
                                weight: 100, provider: pr2, category: c1)

ProductBundle.create!(name: "Kit presente", sku: "D5E9D5E8R7S5D6T9H5Y4",
                      product_models: [product1, product4])
ProductBundle.create!(name: "Kit petisco", sku: "F5G6R9S5F4T7S58T9K62",
                      product_models: [product2, product3])
