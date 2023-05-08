FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'test@test.com' }
    password_digest { 'hash_password' }
  end
end
