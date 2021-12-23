require 'rails_helper'

RSpec.describe Provider, type: :model do
  context 'atributos em branco' do
    it 'Nome fantasia em branco' do
      p = Provider.new(trading_name: '', company_name: 'C Confecções LTDA',
          						 cnpj: '22.281.398/0001-14', address: 'Av Europa 250', 
                       email: 'contato@cconfec.com', phone: '99999-9000')
			
			result = p.valid?

			expect(result).to eq false
     end

		it 'Razão social em branco' do
			p = Provider.new(trading_name: 'C Modas', company_name: '',
											 cnpj: '22.281.398/0001-14', address: 'Av Europa 250', 
											 email: 'contato@cconfec.com', phone: '99999-9000')

			result = p.valid?

			expect(result).to eq false
		end

		it 'cnpj em branco' do
			p = Provider.new(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
										 	 cnpj: '', address: 'Av Europa 250', 
											 email: 'contato@cconfec.com', phone: '99999-9000')

			result = p.valid?

			expect(result).to eq false
		end



		it 'email em branco' do
			p = Provider.new(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
										 	 cnpj: '22.281.398/0001-14', address: 'Av Europa 250', 
											 email: '', phone: '99999-9000')

			result = p.valid?

			expect(result).to eq false
		end
  end

	
	it 'cnpj com fortmato inválido' do
		p = Provider.new(trading_name: 'C Modas', company_name: 'C Confecções LTDA',
											cnpj: '22281398000114', address: 'Av Europa 250', 
											email: 'contato@cconfec.com', phone: '99999-9999')

		result = p.valid?

		expect(result).to eq false
	end


	
end
