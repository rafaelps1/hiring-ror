require 'bcrypt'

class User < ApplicationRecord
  validates :email, uniqueness:true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :password_digest, presence: true

  has_secure_password

  has_many :products, dependent: :destroy
end
