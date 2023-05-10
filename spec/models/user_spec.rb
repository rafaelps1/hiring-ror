require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user_valid) { build(:user) }
    let(:user_invalid) { build(:user, email: 'test') }
    let(:pwd) { BCrypt::Password.create('pwd@g00d$') }

    it 'user valid' do
      expect(user_valid.email).to eq('test@test.com')
      expect(user_valid.password_digest).to eq('has_password')
    end

    it 'user invalid' do
      expect(user_invalid.valid?).to be false
      expect(user_invalid.errors.messages.values).to include(['is invalid'])
    end
  end

  describe 'Associations' do
    let(:user) { build(:user) }
    let!(:product1) { create(:product, user: user) }
    let!(:product2) { create(:product, name: 'Table', user: user) }

    it 'delete user should destroy linked product' do
      expect(Product.all.count).to eq(2)

      user.destroy
      expect(Product.all.count).to eq(0)
    end
  end
end
