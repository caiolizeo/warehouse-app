require 'rails_helper'

describe 'Warehouse API' do
  it 'GET /warehouses' do
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                      address: 'Av Fernandes Lima', city: 'Maceió',
                      state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)
    Warehouse.create!(name: 'São Paulo', code: 'SPX', description: 'galpão em sp',
                      address: 'Av paulista', city: 'São Paulo',
                      state: 'SP', postal_code: '01000-000', total_area: 8000, useful_area: 4500)

    
    get '/api/warehouses'


    expect(response).to have_http_status(200)
    expect(response.content_type).to include('application/json')
    expect(response.body).to include 'Maceió'
    expect(response.body).to include 'São Paulo'
  end

end