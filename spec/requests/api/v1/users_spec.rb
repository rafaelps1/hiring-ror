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

    let(:headers) {{ Authorization: JsonWebToken.encode(user_id: @user.id) }}
    let(:headers_invalid_signature) {{ Authorization: JWT.encode({ user_id: @user.id }, 'bad_signature')}}

    it 'delete user' do
      delete("/api/v1/users/#{@user.id}", headers: headers)
      expect(response).to have_http_status(:no_content)

      get "/api/v1/users/#{@user.id}"
      expect(response).to have_http_status(:not_found)
    end

    it 'with auth to delete user' do
      delete("/api/v1/users/#{@user.id}", headers: headers)
      expect(response).to have_http_status(:no_content)

      get "/api/v1/users/#{@user.id}"
      expect(response).to have_http_status(:not_found)
    end

    # it 'try delete user with auth' do
    #   delete("/api/v1/users/#{@user.id}", headers: headers_invalid_signature)
    #   expect(response).to have_http_status(:forbidden)
    # end
  end
end
