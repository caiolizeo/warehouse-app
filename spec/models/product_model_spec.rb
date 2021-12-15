require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimensions' do

    p = ProductModel.new(height: '14', width: '10', length: '12')

    result = p.dimensions

    expect(result).to eq '14 x 10 x 12'

  end
end
