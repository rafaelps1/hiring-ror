require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  describe 'POST /create' do
    let(:user) { create(:user_pwd_bcrypt) }
    let(:user_auth_params) do
      {
        token: {
          email: user.email,
          password: 'pwd@g00d$'
        }
      }
    end
    let(:user_unauth_params) do
      {
        token: {
          email: user.email,
          password: '12356'
        }
      }
    end
    let(:user_not_found_params) do
      {
        token: {
          email: 'foo@foo.com.',
          password: '12356'
        }
      }
    end

    context 'JWT tokens' do
      it 'should get token' do
        post api_v1_generate_url, params: user_auth_params
        data = json(response)['data']
        token = data.fetch('token')

        expect(response).to have_http_status(:success)
        expect(token).to_not eq(nil)
        expect(token).to_not eq('')
        expect(data.fetch('email')).to eq(user.email)
      end

      it 'should not get token by password invalid' do
        post api_v1_generate_url, params: user_unauth_params
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should not get token by user not found' do
        post api_v1_generate_url, params: user_not_found_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
