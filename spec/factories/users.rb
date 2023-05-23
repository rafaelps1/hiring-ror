FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'test@test.com' }
    password_digest { 'has_password' }
  end

  factory :user_pwd_bcrypt, class: User do
    email { 'test_token@test.com' }
    password_digest { BCrypt::Password.create('pwd@g00d$') }
  end
end
