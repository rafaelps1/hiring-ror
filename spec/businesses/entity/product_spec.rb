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
      product_service = build_service_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.name_length'), source: [:name] }
      expect(product_service.errors).to include(error)
    end

    it 'name unique by product' do
      product_params[:name] = product1.name
      product_service = build_service_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.is_exist'), source: [:name] }
      expect(product_service.errors).to include(error)
    end

    it 'name large by product' do
      product_params[:name] = Faker::Lorem.characters(number: 101)
      product_service = build_service_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.name_length'), source: [:name] }
      expect(product_service.valid?).to be_falsey
      expect(product_service.errors).to include(error)
    end

    it 'price have two digits after decimal point' do
      product_params[:price] = 99.929
      product_service = build_service_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.price_digit'), source: [:price] }
      expect(product_service.valid?).to be_falsey
      expect(product_service.result).to be(nil)
      expect(product_service.errors).to include(error)

      product_params[:price] = -10.21
      product_service = build_service_product(product_params)
      error = { code: 121, message: I18n.t('dry_validation.errors.product.price_negative'), source: [:price] }
      expect(product_service.valid?).to be_falsey
      expect(product_service.result).to be(nil)
      expect(product_service.errors).to include(error)
    end

    it 'url form photo invalid' do
      product_params[:photo] = 'url_invalid'
      product_service = build_service_product(product_params)
      expect(product_service.valid?).to be_falsey
      error = { code: 121, source: [:photo], message: I18n.t('dry_validation.errors.product.photo_url') }
      expect(product_service.errors).to include(error)
    end

    it 'check field state is true by default' do
      product_params[:state] = nil
      expect(product_params[:state]).to be(nil)

      product_service = build_service_product(product_params)
      expect(product_service.valid?).to be(true)
    end
  end

  def build_service_product(product_params)
    prod_sv = ProductService.call
    prod_sv.build_product(product_params)
    prod_sv
  end
end
