require 'rails_helper'

describe 'Product Model API' do
  context 'GET /api/v1/product_models/' do
    it 'com sucesso' do
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
    
      get '/api/v1/product_models'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['name']).to eq 'Caneca Marvel'
      expect(parsed_response[1]['name']).to eq 'Boneco Homem Aranha'
      expect(parsed_response[2]['name']).to eq 'Camiseta Homem de ferro'
      expect(response.body).not_to include 'created_at'
      expect(response.body).not_to include 'updated_at'    
    end

    it 'resposta vazia' do
      get '/api/v1/product_models'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end

    it 'erro no banco de dados'
  end

  context 'GET /api/v1/product_models/:id' do
    it 'com sucesso' do
      prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
        email: 'contato@apresentes.com', phone: '99999-9999')
      c1 = Category.create!(name: 'Outros')
      p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
        weight: 300, provider: prov1, category: c1)

      get "/api/v1/product_models/#{p1.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response['name']).to eq 'Caneca Marvel'
      expect(parsed_response['height']).to eq 14
      expect(parsed_response['width']).to eq 10
      expect(parsed_response['length']).to eq 8
      expect(parsed_response['weight']).to eq 300
      expect(parsed_response['provider_id']).to eq prov1.id
      expect(parsed_response['category_id']).to eq c1.id
      expect(parsed_response['provider']['id']).to eq prov1.id
      expect(parsed_response['provider']['trading_name']).to eq prov1.trading_name
      expect(parsed_response['provider']['company_name']).to eq prov1.company_name
      expect(parsed_response['category']['id']).to eq c1.id
      expect(parsed_response['category']['name']).to eq c1.name
      

    end

    it 'modelo de produto não existe' do

      get '/api/v1/product_models/999999'

      expect(response).to have_http_status(404)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Objeto não encontrado'
    end

    it 'erro no banco de dados' do
      prov1 = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
        email: 'contato@apresentes.com', phone: '99999-9999')
      c1 = Category.create!(name: 'Outros')
      p1 = ProductModel.create!(name: 'Caneca Marvel', height: '14', width: '10', length: '8',
        weight: 300, provider: prov1, category: c1)

      allow(ProductModel).to receive(:find).with(p1.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
    
      get "/api/v1/product_models/#{p1.id}"

      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
    end
  end
end