require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  before do
    @user = FactoryBot.create(:user_record)
    get(api_v1_users_url << "/#{@user.id}")
  end

  let(:show_path) { url_for(only_path: true, controller: 'users', action: 'show', id: @user.id) }
  let(:user_not_found_show_path) { url_for(only_path: true, controller: 'users', action: 'show', id: '12345678') }
  let(:delete_path) { url_for(only_path: true, controller: 'users', action: 'destroy', id: @user.id) }

  describe 'GET /show' do
    it 'return user' do
      data = json(response).fetch('data')
      expect(response).to have_http_status(:success)
      expect(data.fetch('id')).to eq(@user.id)
      expect(data.fetch('name')).to eq(@user.name)
      expect(data.fetch('email')).to eq(@user.email)
    end

    it 'not found user' do
      get user_not_found_show_path
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /users' do
    let(:create_user_path) { url_for(only_path: true, controller: 'users', action: 'create') }
    let(:user_params) { FactoryBot.build(:user_record, email: 'email@email.com').attributes.symbolize_keys }
    let(:new_user_params) { user_params.merge(password: user_params[:password_digest]) }

    it 'should create user' do
      post(create_user_path, params: { user: new_user_params })

      expect(response).to have_http_status(:created)
      expect(response.body).to eq("{\"data\":{\"email\":\"email@email.com\"}}")
    end

    it 'should response with status unprocessable_entity' do
      new_user_params[:email] = @user.email
      post(create_user_path, params: { user: new_user_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq("{\"erros\":[{\"message\":\"[:email] Already exist user with same email.\"}]}")
    end
  end

  describe 'DELETE /destroy' do
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: @user.id) } }
    let(:headers_invalid_signature) { { Authorization: JWT.encode({ user_id: @user.id }, 'bad_signature') } }

    it 'delete user' do
      delete(delete_path, headers: headers)
      expect(response).to have_http_status(:no_content)

      get(show_path)
      expect(response).to have_http_status(:not_found)
    end

    it 'with auth, should not delete user' do
      user_not_found_path = url_for(only_path: true, controller: 'users', action: 'destroy', id: 1_5)
      delete(user_not_found_path, headers: headers)
      expect(response).to have_http_status(:not_found)
    end

    it 'with auth to delete user' do
      delete(delete_path, headers: headers)
      expect(response).to have_http_status(:no_content)

      get(show_path)
      expect(response).to have_http_status(:not_found)
    end

    it 'try delete user with auth' do
      delete(delete_path, headers: headers_invalid_signature)
      expect(response).to have_http_status(:forbidden)
    end
  end
end
