require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'POST /create' do
    let!(:user) { create(:user_pwd_bcrypt) }
    let(:product) { build(:product_record) }
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
    let(:product) { create(:product_record, name: 'test') }

    context 'show one product' do
      before do
        ProductRecord.destroy_all
        get api_v1_products_url(product)
        @json_resp = json(response)
      end

      it 'should list product' do
        expect(response).to have_http_status(:success)
        expect(@json_resp.fetch('data', []).find { |prod| prod['name'] == 'test' }.present?).to be true
      end
    end

    context 'fetch products by name or term his' do
      let!(:car_product) { create(:product_record, name: 'Carro', user: user) }
      let!(:computer_product) { create(:product_record, name: 'Computador', user: user) }
      let!(:pliers_product) { create(:product_record, name: 'Alicate', user: user) }

      before do
        5.times do
          create(:product_record, name: Faker::Name.unique.name, user: user)
        end
      end

      it 'list products' do
        get api_v1_products_url(product), params: { name: 'ca' }
        @json_resp = json(response)
        expect(response).to have_http_status(:success)
        data = @json_resp['data'].to_s
        expect(data).to match('\"name\"=>\"Carro\"')
        expect(data).to match('\"name\"=>\"Alicate\"')
      end

      it 'list products on page 2' do
        get api_v1_products_url(product), params: { page: 2 }
        page = json(response).fetch('links').fetch('rel')
        expect(page).to eq('current page: 2')
      end

      it 'overflow of pagination' do
        get api_v1_products_url(product), params: { name: 'ca', page: 1000 }
        expect(json(response)).to include({ 'errors' => 'expected :page in 1..1; got 1000' })
      end
    end
  end

  describe 'PUT /product/inactive' do
    let!(:user) { create(:user_pwd_bcrypt) }
    let!(:product) { create(:product_record, user: user) }
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
