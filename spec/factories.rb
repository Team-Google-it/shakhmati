FactoryBot.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    birthdate { 21.years.ago }
    admin false

    sequence(:username) { |n| "user#{n}" }
  end
end