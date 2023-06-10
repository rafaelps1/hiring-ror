require 'bcrypt'

class UserRecord < ApplicationRecord
  self.table_name = 'users'

  has_secure_password

  has_many :products, class_name: 'ProductRecord', dependent: :destroy, foreign_key: 'user_id'
end
