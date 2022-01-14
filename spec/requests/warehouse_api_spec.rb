require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'com sucesso' do
      c1 = Category.create!(name: 'Vestuário')
      c2 = Category.create!(name: 'Eletrônicos')
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                        address: 'Av Fernandes Lima', city: 'Maceió', categories: [c1, c2],
                        state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'galpão em sp',
                        address: 'Av paulista', city: 'São Paulo', categories: [c1],
                        state: 'SP', postal_code: '01000-000', total_area: 8000, useful_area: 4500)

      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['name']).to eq 'Maceió'
      expect(parsed_response[0]['categories'][0]['name']).to eq 'Vestuário'
      expect(parsed_response[0]['categories'][1]['name']).to eq 'Eletrônicos'
      expect(parsed_response[1]['name']).to eq 'São Paulo'
      expect(parsed_response[1]['categories'][0]['name']).to eq 'Vestuário'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av Paulista'
    end

    it 'Nenhum galpão cadastrado' do
      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response['alert']).to eq 'Nenhum galpão cadastrado'
    end

    it 'erro no banco de dados' do
      c1 = Category.create!(name: 'Vestuário')
      c2 = Category.create!(name: 'Eletrônicos')
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                        address: 'Av Fernandes Lima', city: 'Maceió', categories: [c1, c2],
                        state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
      allow(Warehouse).to receive(:all).and_raise ActiveRecord::ConnectionNotEstablished                        
    
      get '/api/v1/warehouses'

      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'com sucesso' do
      c1 = Category.create!(name: 'Vestuário')
      c2 = Category.create!(name: 'Eletrônicos')
      w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                            address: 'Av Fernandes Lima', city: 'Maceió', categories: [c1, c2],
                            state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

      get "/api/v1/warehouses/#{w.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response['name']).to eq 'Maceió'
      expect(parsed_response['code']).to eq 'MCZ'
      expect(parsed_response['description']).to eq 'Ótimo galpão'
      expect(parsed_response['city']).to eq 'Maceió'
      expect(parsed_response['state']).to eq 'AL'
      expect(parsed_response['postal_code']).to eq '57050-000'
      expect(parsed_response['categories'][0]['name']).to eq 'Vestuário'
      expect(parsed_response['categories'][1]['name']).to eq 'Eletrônicos'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'Galpão não existe' do

      get "/api/v1/warehouses/123"

      expect(response).to have_http_status(404)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Objeto não encontrado'
    end

    it 'erro no banco de dados' do
      c1 = Category.create!(name: 'Vestuário')
      c2 = Category.create!(name: 'Eletrônicos')
      w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                            address: 'Av Fernandes Lima', city: 'Maceió', categories: [c1, c2],
                            state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
      allow(Warehouse).to receive(:find).with(w.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished                        
      get "/api/v1/warehouses/#{w.id}"

      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'com sucesso' do

      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/warehouses', params: '{"name": "Maceió",
                                          "code": "MCZ",
                                          "description": "Ótimo galpão",
                                          "address": "Avenida X",
                                          "city": "Maceió",
                                          "state": "AL",
                                          "postal_code": "57050-000",
                                          "total_area": 10000,
                                          "useful_area": 8000}', 
                                 headers: headers

      expect(response).to have_http_status(201)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
      expect(parsed_response['name']).to eq 'Maceió'
      expect(parsed_response['code']).to eq 'MCZ'
    end

    it 'campos são exigidos' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/warehouses', params: '{"description": "Ótimo galpão",
                                          "address": "Avenida X",
                                          "city": "Maceió",
                                          "state": "AL",
                                          "postal_code": "57050-000",
                                          "total_area": 10000,
                                          "useful_area": 8000}', 
                                 headers: headers

      expect(response).to have_http_status(422)
      expect(response.body).to include 'Nome não pode ficar em branco'
      expect(response.body).to include 'Código não pode ficar em branco'
    end

    it 'código e nome não são únicos' do
      w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
        address: 'Av Fernandes Lima', city: 'Maceió',
        state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/warehouses', params: '{"name": "Maceió",
                                          "code": "MCZ",
                                          "description": "Ótimo galpão",
                                          "address": "Avenida X",
                                          "city": "Maceió",
                                          "state": "AL",
                                          "postal_code": "57050-000",
                                          "total_area": 10000,
                                          "useful_area": 8000}', 
                                 headers: headers
                                 
      expect(response).to have_http_status(422)
      expect(response.body).to include 'Nome já está em uso'
      expect(response.body).to include 'Código já está em uso'
    end

    it 'erro no banco de dados' do
      allow(Warehouse).to receive(:new).and_raise ActiveRecord::ConnectionNotEstablished                        
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/warehouses', params: '{"name": "Maceió",
                                          "code": "MCZ",
                                          "description": "Ótimo galpão",
                                          "address": "Avenida X",
                                          "city": "Maceió",
                                          "state": "AL",
                                          "postal_code": "57050-000",
                                          "total_area": 10000,
                                          "useful_area": 8000}', 
                                 headers: headers

      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
    end
  end
end