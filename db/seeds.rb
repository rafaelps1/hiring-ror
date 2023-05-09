# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

User.delete_all
user = User.create! email: 'admin@admin.com', password: 'admin123'
puts "Created a new user: #{user.email}"
