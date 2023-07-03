ProductRecord.delete_all
UserRecord.delete_all

user = UserRecord.create!(email: 'admin@admin.com', name: 'admin', password: 'admin')
puts "Created a new user: #{user.email}"

15.times do
  FactoryBot.create(:product_record, name: Faker::Name.unique.name, user: user)
end
