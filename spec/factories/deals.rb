FactoryBot.define do
  factory :deal do
    title '60% discount on iPhone'
    price '110'
    savings 'Savings of upto 50%'
    discount_code 'COOLBUY'
    link 'http://example.com'
    brand
    user
  end
end
