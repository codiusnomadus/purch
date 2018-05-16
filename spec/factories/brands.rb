FactoryBot.define do
  factory :brand do
    name 'Apple'
    initialize_with { Brand.find_or_create_by(code: 'APPLE') }
    active true
  end
end
