require 'rails_helper'

describe 'Warehouse Requests', type: :request do
  it 'deve recusar a criação se não estiver autenticado' do
    
    post '/warehouses'

    expect(response.status).to eq 302
    expect(response).to redirect_to(new_user_session_path)
  end

end