require 'rails_helper'

RSpec.describe Entity::User, type: :entity do
  describe 'Validations' do
    let(:user_valid_params) { build(:user_record, name: 'Myname').attributes.symbolize_keys.except(:id) }
    let(:user_invalid_params) { build(:user_record, email: 'test').attributes.symbolize_keys.except(:id) }
    let(:pwd) { BCrypt::Password.create('pwd@g00d$') }

    it 'user valid' do
      new_user = valid(user_valid_params)
      result = sanitize(new_user)

      expect(result).to eq([])
      expect(@new_user.name).to eq('Myname')
      expect(@new_user.email).to eq('test@test.com')
      expect(@new_user.password_digest).to eq('has_password')
    end

    it 'user invalid' do
      result = sanitize(valid(user_invalid_params))
      expect(result).to include([I18n.t('dry_validation.errors.user.email_invalid')])

      user_invalid_params[:email] = 'admin@admin.com'
      result = sanitize(valid(user_invalid_params))
      expect(result).to include([I18n.t('dry_validation.errors.user.is_exist')])
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

  def valid(params)
    @new_user = Entity::User.new(params)
    Entity::Contract::UserContract.new.call(@new_user.attributes)
  end
end
