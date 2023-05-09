require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'POST /create' do
    let!(:user) { create(:user_pwd_bcrypt) }
    let(:product) { build(:product) }
    let(:headers) {
      { Authorization: JsonWebToken.encode(user_id: user.id) }
    }
    let(:valids_params) {
      {
        product: {
          name: product.name,
          title: product.title,
          price: product.price,
          photo: product.photo,
          state: product.state
        }
      }
    }

    it 'should create product' do
      post(api_v1_products_url, params: valids_params, headers: headers)
      expect(response).to have_http_status(:created)
    end

    it 'should forbid create product' do
      post(api_v1_products_url, params: valids_params)
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'GET /index' do
    let(:user) { build(:user_pwd_bcrypt) }
    let(:product) { create(:product) }

    context 'show one product' do
      before do
        get api_v1_products_url(product)
        @json_response = JSON.parse(response.body)
      end
  
      it 'list product' do
        expect(response).to have_http_status(:success)
        expect(product.name).to eq(@json_response.first['name'])
      end
    end

    context 'show many products in the list' do
      xit 'products with pagenation' do
      end
    end
  end

  describe 'PUT /product/inactive' do
    let!(:user) { create(:user_pwd_bcrypt) }
    let!(:product) { create(:product, user: user) }
    let(:headers) {
      { Authorization: JsonWebToken.encode(user_id: user.id) }
    }

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
