FactoryGirl.define do
  factory :signature do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    sequence(:email) { |n| "person#{n}@example.com" }
    zipcode { Faker::Address.zip_code }
  end
end