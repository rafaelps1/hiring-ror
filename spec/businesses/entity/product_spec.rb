require 'rails_helper'

RSpec.describe Entity::Product, type: :entity do
  describe 'Validations by dry-validation' do
    let(:user) { build(:user_record) }
    let(:product_params) { build(:product_record).attributes.symbolize_keys.except(:id) }
    let!(:product1) { create(:product_record, user: user) }

    it 'product without name' do
      message = '[Entity::Product.new] :name is missing in Hash input'
      expect { Entity::Product.new(product_params.except(:name)) }.to raise_error(Dry::Struct::Error, message)

      product_params[:name] = ''
      new_product = build_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.name_length'), source: [:name] }
      expect(new_product.failure).to include(error)
    end

    it 'name unique by product' do
      product_params[:name] = product1.name
      new_product = build_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.is_exist'), source: [:name] }
      expect(new_product.failure?).to be_truthy
      expect(new_product.failure).to include(error)
    end

    it 'name large by product' do
      product_params[:name] = Faker::Lorem.characters(number: 101)
      new_product = build_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.name_length'), source: [:name] }
      expect(new_product.failure?).to be_truthy
      expect(new_product.failure).to include(error)
    end

    it 'price have two digits after decimal point' do
      product_params[:price] = 99.929
      new_product = build_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.price_digit'), source: [:price] }
      expect(new_product.failure?).to be_truthy
      expect(new_product.failure).to include(error)

      product_params[:price] = -10.21
      new_product = build_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.price_negative'), source: [:price] }
      expect(new_product.failure?).to be_truthy
      expect(new_product.failure).to include(error)
    end

    it 'url form photo invalid' do
      product_params[:photo] = 'url_invalid'
      new_product = build_product(product_params)
      expect(new_product.success?).to be_falsey
      error = { code: 121, source: [:photo], message: I18n.t('dry_validation.errors.product.photo_url') }
      expect(new_product.failure).to include(error)
    end

    it 'check field state is true by default' do
      product_params[:state] = nil
      expect(product_params[:state]).to be(nil)

      new_product = build_product(product_params)
      expect(new_product.success?).to be(true)
      expect(new_product.success.state).to eq(product_params[:state])
    end
  end

  def build_product(product_params)
    ProductService.new.call(product_hash: product_params).send(:build_product)
  end
end
