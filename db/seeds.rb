ProductRecord.delete_all
User.delete_all

user = User.create!(email: 'admin@admin.com', password: 'admin')
puts "Created a new user: #{user.email}"

15.times do
  FactoryBot.create(:product_record, name: Faker::Name.unique.name, user: user)
end
