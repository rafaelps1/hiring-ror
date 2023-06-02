FactoryBot.define do
  factory :product_record do
    name { Faker::Lorem.characters(number: 99) }
    title { 'Product A' }
    price { 99.92 }
    photo { 'https://storage.com.br/img2' }
    user
  end
end
