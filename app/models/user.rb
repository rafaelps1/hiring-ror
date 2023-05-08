require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :email, uniqueness:true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :password_digist, presence: true

  def password
      @password ||= Password.new(password_digist)
    end
  
    def password=(new_password)
      @password = Password.create(new_password)
      self.password_digist = @password
    end
end
