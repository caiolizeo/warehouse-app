require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'sucesso' do
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                        address: 'Av Fernandes Lima', city: 'Maceió',
                        state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'galpão em sp',
                        address: 'Av paulista', city: 'São Paulo',
                        state: 'SP', postal_code: '01000-000', total_area: 8000, useful_area: 4500)

      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['name']).to eq 'Maceió'
      expect(parsed_response[1]['name']).to eq 'São Paulo'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av Paulista'
    end

    it 'resposta vazia' do
      get '/api/v1/warehouses'
      
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end
end