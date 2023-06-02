require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user_valid) { build(:user, name: 'Myname') }
    let(:user_invalid) { build(:user, email: 'test') }
    let(:pwd) { BCrypt::Password.create('pwd@g00d$') }

    it 'user valid' do
      expect(user_valid.name).to eq('Myname')
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
    let!(:product1) { create(:product_record, user: user) }
    let!(:product2) { create(:product_record, name: 'Table', user: user) }

    it 'delete user should destroy linked product' do
      expect(ProductRecord.all.count).to eq(17)

      user.destroy
      expect(ProductRecord.all.count).to eq(15)
    end
  end
end
