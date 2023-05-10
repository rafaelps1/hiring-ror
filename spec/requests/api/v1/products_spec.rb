require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'POST /create' do
    let!(:user) { create(:user_pwd_bcrypt) }
    let(:product) { build(:product) }
    let(:headers) do
      { Authorization: JsonWebToken.encode(user_id: user.id) }
    end
    let(:valids_params) do
      {
        product: {
          name: product.name,
          title: product.title,
          price: product.price,
          photo: product.photo,
          state: product.state
        }
      }
    end

    it 'should create product' do
      post(api_v1_products_url, params: valids_params, headers: headers)
      expect(response).to have_http_status(:created)
    end

    it 'should forbidden create product' do
      post(api_v1_products_url, params: valids_params)
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'GET /index' do
    let(:user) { build(:user_pwd_bcrypt) }
    let(:product) { create(:product, name: 'test') }

    context 'show one product' do
      before do
        get api_v1_products_url(product)
        @json_response = JSON.parse(response.body)
      end

      it 'should list product' do
        expect(response).to have_http_status(:success)
        product_name = @json_response['products']&.first&.[]('name')
        expect(product.name).to eq(product_name)
      end
    end

    context 'fetch products by name or term his' do
      let!(:car_product) { create(:product, name: 'Carro', user: user) }
      let!(:computer_product) { create(:product, name: 'Computador', user: user) }
      let!(:pliers_product) { create(:product, name: 'Alicate', user: user) }

      before do
        5.times do
          create(:product, name: Faker::Name.unique.name, user: user)
        end
        get api_v1_products_url(product), params: { term: 'ca' }
        @json_response = JSON.parse(response.body)
      end

      it 'list products' do
        expect(response).to have_http_status(:success)
        expect(@json_response['products'].size).to eq(2)
      end

      it 'list products on page 2' do
        get api_v1_products_url(product), params: { page: 2 }
        @json_response = JSON.parse(response.body)
        expect(@json_response['pagination']['vars']['page']).to eq('2')
      end
    end
  end

  describe 'PUT /product/inactive' do
    let!(:user) { create(:user_pwd_bcrypt) }
    let!(:product) { create(:product, user: user) }
    let(:headers) do
      { Authorization: JsonWebToken.encode(user_id: user.id) }
    end

    it 'should inactive product' do
      put(api_v1_product_inactive_url(product))
      expect(response).to have_http_status(:success)
    end

    it 'should not inactive product' do
      product.update(state: false)
      put(api_v1_product_inactive_url(product))
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
