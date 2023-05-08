require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /show' do
    before do
      @user = FactoryBot.create(:user)
      get "/api/v1/users/#{@user.id}"
    end

    it 'return user' do
      expect(response).to have_http_status(:success)
    end

    it 'not found user' do
      get '/api/v1/users/12345678'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /destroy' do
    before do
      @user = FactoryBot.create(:user)
      get "/api/v1/users/#{@user.id}"
    end

    it 'delete user' do
      delete "/api/v1/users/#{@user.id}"
      expect(response).to have_http_status(:no_content)

      get "/api/v1/users/#{@user.id}"
      expect(response).to have_http_status(:not_found)
    end
  end
end
