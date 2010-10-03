require 'machinist/active_record'
require 'sham'
require 'faker'

Account.blueprint do
  email    { Faker::Internet.email }
  password { "password" }
end

Profile.blueprint do
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  bio        { Faker::Lorem.paragraph }
  city       { Faker::Address.city }
  state      { Faker::Address.us_state }
  occupation { 'Developer' }
  company    { Faker::Company.name }
  website    { Faker::Internet.domain_name }
end

Product.blueprint do
  name         { Faker::Lorem.words(5) }
  description  { Faker::Lorem.paragraph }
  price        { 5.00 }
  credit_value { 5 }
end

PurchaseItem.blueprint do

end