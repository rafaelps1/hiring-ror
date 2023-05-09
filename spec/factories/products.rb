FactoryBot.define do
  factory :product do
    name { Faker::Lorem.characters(number: 99) }
    price { 99.92 }
    photo { 'https://storage.com.br/img2' }
    user
  end

  # factory :negative_price_product do
  #   name { Faker::Lorem.characters(number: 99) }
  #   price { -1 }
  #   photo { 'https://storage.com.br/img3' }
  # end
end
