require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  it 'Deve gerar um código de 20 caractéres' do 
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    pm = ProductModel.new(name: 'Caneca', height: 14, width: 10, length: 8,
                               weight: 300, provider: p, category: c)
    
    
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                         address: 'Av Fernandes Lima', city: 'Maceió',
                         state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)        
    item = ProductItem.create!(warehouse: w, product_model: pm)

    

    expect(item.code.length).to eq 20
  end
end
