require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:user) { build(:user) }
    let!(:product1) { create(:product, user: user) }

    it 'product without name' do
      product_without_name = build(:product, name: nil, user: user)
      expect(product_without_name.valid?).to be false
    end

    it 'name unique by product' do
      product_unique_name = build(:product, name: product1.name, user: user)
      expect(product_unique_name.valid?).to be false
    end

    it 'name large by product' do
      product1.name = Faker::Lorem.characters(number: 101)
      expect(product1.save).to be false
    end
    
    it 'price have two digits after decimal point' do
      product1.price = 99.929
      expect(product1.save).to be false
    end

    it 'url form photo invalid' do
      product1.photo = 'url_invalid'
      expect(product1.save).to be false
    end

    it 'check product state is true by default' do
      expect(product1.state).to be true
    end
  end
end
