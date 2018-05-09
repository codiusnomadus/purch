FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "jon#{n}@example.com" }
    password 'Pass1234'
    password_confirmation 'Pass1234'
  end
end
