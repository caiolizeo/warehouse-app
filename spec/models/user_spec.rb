require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email duplicado' do
    user1 = User.create(email: 'email@teste.com', password: '123456789')
    user2 = User.create(email: 'email@teste.com', password: 'abcdefghi')

    result = user2.valid?

    expect(result).to eq false
  end
  
  it 'senha menor que 6 dígitos' do
    user1 = User.create(email: 'email@teste.com', password: '12345')

    result = user1.valid?

    expect(result).to eq false
  end

  context 'email com formato inválido' do
    it 'email sem domínio' do
      user1 = User.new(email: 'email@', password: '123456789')
      
      result = user1.valid?

      expect(result).to eq false
    end

    it 'email sem @' do
      user1 = User.new(email: 'emailteste.com', password: '123456789')

      result = user1.valid?

      expect(result).to eq false
    end

    it 'email sem nome do usuario' do
      user1 = User.new(email: '@teste.com', password: '123456789')

      result = user1.valid?

      expect(result).to eq false
    end
  end
end
