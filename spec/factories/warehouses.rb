FactoryBot.define do
  factory :warehouse do
    name {'Santos'}
    code  {'STS'}
    description {'Um galpão no litoral'}
    address {'Av. abc'}
    postal_code {'01000-000'}
    city {'Santos'}
    state {'SP'}
    total_area {10_000}
    useful_area {8_000}
    categories {nil}
  end
end