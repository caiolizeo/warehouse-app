require 'rails_helper'

describe 'Supplier API' do
  context 'GET /api/v1/suppliers' do
    it 'com sucesso' do
      Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
        email: 'contato@apresentes.com', phone: '99999-9999')

      Provider.create!(trading_name: 'xyz metalúrgica', company_name: 'metalúrgica xyz LTDA',
        cnpj: '72.074.830/0001-74', address: 'Av Pres. Wilson 521',
        email: 'xyz_met@email.com', phone: '99999-9999')

      Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
        cnpj: '22.281.398/0001-14', address: 'Av Europa 250', 
        email: 'contato@cconfec.com', phone: '99999-9000')
    
      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['trading_name']).to eq 'A Presentes'
      expect(parsed_response[1]['trading_name']).to eq 'xyz metalúrgica'
      expect(parsed_response[2]['trading_name']).to eq 'C Modas'
      expect(response.body).not_to include 'created_at'
      expect(response.body).not_to include 'updated_at'
    end

    it 'resposta vazia' do
      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/suppliers/:id' do
    it 'com sucesso' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
        email: 'contato@apresentes.com', phone: '99999-9999')
        
      get "/api/v1/suppliers/#{p.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response['trading_name']).to eq 'A Presentes'
      expect(parsed_response['company_name']).to eq 'A importações LTDA ME'
      expect(parsed_response['cnpj']).to eq '08.385.207/0001-33'
      expect(parsed_response['address']).to eq 'Av Paulista 500'
      expect(parsed_response['email']).to eq 'contato@apresentes.com'
      expect(parsed_response['phone']).to eq '99999-9999'
    end

    it 'fornecedor não existe' do
      get '/api/v1/suppliers/123'

      expect(response).to have_http_status(404)
    end
  end
end