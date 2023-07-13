require 'rails_helper'

RSpec.describe Entity::User, type: :entity do
  describe 'Validations' do
    let(:user_valid_params) { build(:user_record, name: 'Myname').attributes.symbolize_keys.except(:id) }
    let(:user_invalid_params) { build(:user_record, email: 'test').attributes.symbolize_keys.except(:id) }
    let(:pwd) { BCrypt::Password.create('pwd@g00d$') }

    it 'user valid' do
      new_user = build_service_user(user_valid_params)
      user = new_user.success

      expect(new_user.success?).to be_truthy
      expect(user.name).to eq('Myname')
      expect(user.email).to eq('test@test.com')
      expect(user.password_digest).to eq('has_password')
    end

    it 'user invalid' do
      new_user = build_service_user(user_invalid_params)
      error = { id: 130, title: I18n.t('dry_validation.errors.user.email_invalid'), source: [:email] }
      expect(new_user.failure).to include(error)

      user_invalid_params[:email] = 'admin@admin.com'
      new_user = build_service_user(user_invalid_params)
      error = { id: 130, title: I18n.t('dry_validation.errors.user.is_exist'), source: [:email] }
      expect(new_user.failure).to include(error)
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
    UserService.new.call(user_hash: product_params).send(:build_user)
  end
end
