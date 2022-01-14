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

    it 'erro no banco de dados' do
      Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
        email: 'contato@apresentes.com', phone: '99999-9999')
      allow(Provider).to receive(:all).and_raise ActiveRecord::ConnectionNotEstablished

      get '/api/v1/suppliers'

      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
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
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Objeto não encontrado'
    end

    it 'erro no banco de dados' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
        cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
        email: 'contato@apresentes.com', phone: '99999-9999')
        allow(Provider).to receive(:find).with(p.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
      
        get "/api/v1/suppliers/#{p.id}"

      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
    end
  end

  context 'POST /api/v1/suppliers' do
    it 'com sucesso' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{"trading_name": "A Presentes",
                                           "company_name": "A importações LTDA ME",
                                           "cnpj": "21.749.641/0001-13",
                                           "address": "Av Paulista 500",
                                           "email": "contato@jpresentes.com",
                                           "phone": "99999-9999"}',
                                 headers: headers

        expect(response).to have_http_status(201)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["id"]).to be_a_kind_of(Integer)
        expect(parsed_response['trading_name']).to eq 'A Presentes'
        expect(parsed_response['company_name']).to eq 'A importações LTDA ME'
        expect(parsed_response['cnpj']).to eq '21.749.641/0001-13'
        expect(parsed_response['address']).to eq 'Av Paulista 500'
        expect(parsed_response['email']).to eq 'contato@jpresentes.com'
        expect(parsed_response['phone']).to eq '99999-9999'
    end

    it 'campos são exigidos' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{}', headers: headers
     
      expect(response).to have_http_status(422)
      parsed_response = JSON.parse(response.body)
      expect(response.body).to include 'Nome fantasia não pode ficar em branco'
      expect(response.body).to include 'Razão social não pode ficar em branco'
      expect(response.body).to include 'Cnpj não pode ficar em branco'
      expect(response.body).to include 'Email não pode ficar em branco'
      expect(response.body).to include 'Cnpj possui formato inválido'
    end

    it 'cnpj é único' do
      Provider.create!(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
        cnpj: '22.281.398/0001-14', address: 'Av Europa 250', 
        email: 'contato@cconfec.com', phone: '99999-9000')

      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{"trading_name": "A Presentes",
                                          "company_name": "A importações LTDA ME",
                                          "cnpj": "22.281.398/0001-14",
                                          "address": "Av Paulista 500",
                                          "email": "contato@jpresentes.com",
                                          "phone": "99999-9999"}', 
                                headers: headers
     
      expect(response).to have_http_status(422)
      parsed_response = JSON.parse(response.body)
      expect(response.body).to include 'Cnpj já está em uso'
    end

    it 'erro no banco de dados' do
      allow(Provider).to receive(:new).and_raise ActiveRecord::ConnectionNotEstablished
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{"trading_name": "A Presentes",
                                          "company_name": "A importações LTDA ME",
                                          "cnpj": "22.281.398/0001-14",
                                          "address": "Av Paulista 500",
                                          "email": "contato@jpresentes.com",
                                          "phone": "99999-9999"}', 
                                headers: headers
                                
      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro de conexão com o servidor'
    end

  end
end