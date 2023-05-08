require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user_valid) { build(:user) }
    let(:user_invalid) { build(:user, email: 'test') }

    it 'user valid' do
      expect(user_valid.email).to eq('test@test.com')
      expect(user_valid.password_digest).to eq('hash_password')
    end

    it 'user invalid' do
      expect(user_invalid.valid?).to be false
      expect(user_invalid.errors.messages.values).to include(["is invalid"])
    end
  end
end
