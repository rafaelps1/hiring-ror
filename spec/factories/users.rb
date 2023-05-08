FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password_digist { 'hash_password' }
  end
end
