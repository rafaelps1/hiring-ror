require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  describe 'POST /create' do
    let(:user) { create(:user_pwd_bcrypt) }
    let(:user_auth_params) do
      {
        user: {
          email: user.email,
          password: 'pwd@g00d$'
        }
      }
    end
    let(:user_unauth_params) do
      {
        user: {
          email: user.email,
          password: '12356'
        }
      }
    end

    context 'JWT tokens' do
      it 'should get token' do
        post('/api/v1/tokens', params: user_auth_params)
        @json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(@json_response['token']).to_not eq(nil)
      end

      it 'should not get token' do
        post('/api/v1/tokens', params: user_unauth_params)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
