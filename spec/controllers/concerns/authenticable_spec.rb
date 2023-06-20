require 'rails_helper'

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

RSpec.describe Authenticable do
  describe '#current_user' do
    before do
      @user = create(:user_pwd_bcrypt)
      @auth_controller = MockController.new
    end

    it 'should get user from Authorization token' do
      @auth_controller.request.headers['Authorization'] = Authenticable::JsonWebToken.encode(user_id: @user.id)
      expect(@user.id).to eq(@auth_controller.current_user.id)
    end

    it 'should not get user from empty Authorization token' do
      @auth_controller.request.headers['Authorization'] = nil
      expect(@auth_controller.current_user).to eq(nil)
    end
  end
end
