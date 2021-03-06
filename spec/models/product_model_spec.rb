require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimensions' do
    p = ProductModel.new(height: '14', width: '10', length: '12')

    result = p.dimensions

    expect(result).to eq '14 x 10 x 12'
  end

  it 'Deve gerar um SKU' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    product = ProductModel.new(name: 'Caneca', height: 14, width: 10, length: 8,
                                   weight: 300, provider: p, category: c)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return 'sdgeessxsk333ddolllf'

    product.save

    expect(product.sku).not_to eq nil
    expect(product.sku).to eq 'SDGEESSXSK333DDOLLLF'
    expect(product.sku.length).to eq 20
  end

  it 'Não deve atualizar o SKU' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                         cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                         email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    product = ProductModel.create!(name: 'Caneca', height: 14, width: 10, length: 8,
                               weight: 300, provider: p, category: c)
    sku = product.sku
    
    product.update(name: 'Copo')
    
    expect(product.name).to eq 'Copo'
    expect(product.sku).to eq sku
  end

  it 'Código SKU é único' do
    p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                             cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                             email: 'contato@apresentes.com', phone: '99999-9999')
    c = Category.create!(name: 'Outros')
    product1 = ProductModel.create!(name: 'Caneca', height: 14, width: 10, length: 8,
                                   weight: 300, provider: p, category: c)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return product1.sku
    product2 = ProductModel.create(name: 'Caneca', height: 14, width: 10, length: 8,
                                    weight: 300, provider: p, category: c)
     
    result =  product2.valid?

    expect(result).to eq false
  end

  context 'atributos em branco: ' do
    it 'Nome em branco' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')

      product = ProductModel.new(name: '', height: 14, width: 10, length: 8,
                                weight: 300, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Altura em branco' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')

      product = ProductModel.new(name: 'Caneca', height: '', width: 10, length: 8,
                                weight: 300, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Largura em branco' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')

      product = ProductModel.new(name: 'Caneca', height: 14, width: '', length: 8,
                                weight: 300, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Profundidade em branco' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')

      product = ProductModel.new(name: 'Caneca', height: 14, width: 10, length: '',
                                weight: 300, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Peso em branco' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')

      product = ProductModel.new(name: 'Caneca', height: 14, width: 10, length: 8,
                                weight: '', provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Fornecedor em branco' do
      product = ProductModel.new(name: 'Caneca', height: 14, width: 6, length: 8,
                                weight: 300)
      
      result = product.valid?

      expect(result).to eq false
    end
  end

  context 'atributos numéricos inválidos' do
    it 'Altura menor que 1' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')
      product = ProductModel.new(name: 'Caneca', height: 0, width: 10, length: 8,
                                weight: 5, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Largura menor que 1' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')
      product = ProductModel.new(name: 'Caneca', height: 10, width: 0, length: 8,
                                weight: 5, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Profundidade menor que 1' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')
      product = ProductModel.new(name: 'Caneca', height: 10, width: 10, length: 0,
                                weight: 5, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end

    it 'Peso menor que 1' do
      p = Provider.create!(trading_name: 'A Presentes', company_name: 'A importações LTDA ME',
                               cnpj: '08.385.207/0001-33', address: 'Av Paulista 500',
                               email: 'contato@apresentes.com', phone: '99999-9999')
      product = ProductModel.new(name: 'Caneca', height: 10, width: 10, length: 0,
                                weight: 0, provider: p)
      
      result = product.valid?

      expect(result).to eq false
    end
  end
end
