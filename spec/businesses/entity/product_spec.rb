require 'rails_helper'

RSpec.describe Entity::Product, type: :entity do
  describe 'Validations by dry-validation' do
    let(:user) { build(:user) }
    let(:product_params) { build(:product_record).attributes.symbolize_keys.except(:id) }
    let!(:product1) { create(:product_record) }

    it 'product without name' do
      message = '[Entity::Product.new] :name is missing in Hash input'
      expect { Entity::Product.new(product_params.except(:name)) }.to raise_error(Dry::Struct::Error, message)

      product_params[:name] = ''
      result = sanitize(valid(product_params))
      expect(result).to include([I18n.t('dry_validation.errors.product.name_length')])
    end

    it 'name unique by product' do
      product_params[:name] = product1.name
      result = sanitize(valid(product_params))
      expect(result).to include([I18n.t('dry_validation.errors.product.is_exist')])
    end

    it 'name large by product' do
      product_params[:name] = Faker::Lorem.characters(number: 101)
      result = sanitize(valid(product_params))
      expect(result).to include([I18n.t('dry_validation.errors.product.name_length')])
    end

    it 'price have two digits after decimal point' do
      product_params[:price] = 99.929
      result = sanitize(valid(product_params))
      expect(result).to include([I18n.t('dry_validation.errors.product.price_digit')])

      product_params[:price] = -10.21
      result = sanitize(valid(product_params))
      expect(result).to include([I18n.t('dry_validation.errors.product.price_negative')])
    end

    it 'url form photo invalid' do
      product_params[:photo] = 'url_invalid'
      result = sanitize(valid(product_params))
      expect(result).to include([I18n.t('dry_validation.errors.product.photo_url')])
    end

    it 'check product state is true by default' do
      product_params[:state] = nil
      expect(product_params[:state]).to be(nil)

      result = sanitize(valid(product_params))
      expect(result.empty?).to be(true)
      expect(@new_product.state).to be(true)
    end
  end

  def valid(params)
    @new_product = Entity::Product.new(params)
    Contract::ProductContract.new.call(@new_product.attributes)
  end

  def sanitize(data)
    data.errors.to_h.flatten
  end
end
