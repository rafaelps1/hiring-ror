require 'rails_helper'

RSpec.describe Entity::User, type: :entity do
  describe 'Validations' do
    let(:user_valid_params) { build(:user_record, name: 'Myname').attributes.symbolize_keys.except(:id) }
    let(:user_invalid_params) { build(:user_record, email: 'test').attributes.symbolize_keys.except(:id) }
    let(:pwd) { BCrypt::Password.create('pwd@g00d$') }

    it 'user valid' do
      user_service = build_service_user(user_valid_params)
      new_user = user_service.repository.user

      expect(user_service.result).to eq(nil)
      expect(new_user.name).to eq('Myname')
      expect(new_user.email).to eq('test@test.com')
      expect(new_user.password_digest).to eq('has_password')
    end

    it 'user invalid' do
      user_service = build_service_user(user_invalid_params)
      error = { code: 130, message: I18n.t('dry_validation.errors.user.email_invalid'), source: [:email] }
      expect(user_service.errors).to include(error)

      user_invalid_params[:email] = 'admin@admin.com'
      user_service = build_service_user(user_invalid_params)
      error = { code: 130, message: I18n.t('dry_validation.errors.user.is_exist'), source: [:email] }
      expect(user_service.errors).to include(error)
    end
  end

  describe 'Associations' do
    let(:user) { build(:user_record) }
    let!(:product1) { create(:product_record, user: user) }
    let!(:product2) { create(:product_record, name: 'Table', user: user) }

    it 'delete user should destroy linked product' do
      expect(ProductRecord.all.count).to eq(17)
      expect(product1.user.email).to eq(user.email)
      expect(product2.user.name).to eq(user.name)

      user.destroy
      expect(ProductRecord.all.count).to eq(15)
    end
  end

  def build_service_user(product_params)
    user_sv = UserService.call
    user_sv.build_user(product_params)
    user_sv
  end
end
