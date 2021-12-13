require "rails_helper"

RSpec.describe Warehouse, type: :model do
  it 'código duplicado' do

    warehouse = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão',
                               address: 'Av Fernandes Lima', city: 'Maceió',
                               state: 'AL', postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    warehouse2 = Warehouse.new(name: 'Guarulhos', code: 'MCZ', description: 'Galpão em Guarulhos',
                             address: 'Rua x', city: 'Guarulhos', state: 'SP', postal_code: '04200-000',
                             total_area: 5000, useful_area: 3000)

    result = warehouse2.valid?

    expect(result).to eq false
  end

  context 'cep inválido não pode ser registrado' do
    it 'cep sem - ' do
      warehouse2 = Warehouse.new(name: 'Guarulhos', code: 'MCZ', description: 'Galpão em Guarulhos',
                                address: 'Rua x', city: 'Guarulhos', state: 'SP', postal_code: '04200000',
                                total_area: 5000, useful_area: 3000)

      result = warehouse2.valid?

      expect(result).to eq false
    end

    it 'cep com uma letra' do
      warehouse2 = Warehouse.new(name: 'Guarulhos', code: 'MCZ', description: 'Galpão em Guarulhos',
                                address: 'Rua x', city: 'Guarulhos', state: 'SP', postal_code: 'o0200000',
                                total_area: 5000, useful_area: 3000)
      
      result = warehouse2.valid?

      expect(result).to eq false
    end

    it 'cep com espaços' do
      warehouse2 = Warehouse.new(name: 'Guarulhos', code: 'MCZ', description: 'Galpão em Guarulhos',
                                address: 'Rua x', city: 'Guarulhos', state: 'SP', postal_code: '     -   ',
                                total_area: 5000, useful_area: 3000)

      result = warehouse2.valid?

      expect(result).to eq false
    end
  end
end
