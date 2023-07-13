module Api
  module V1
    class TokensController < ApplicationController
      # POST /tokens
      def generate
        login = LoginTokenService.call(email: user_params[:email], password: user_params[:password]).result
        @login = login.success and return if login.success?

        head :unauthorized
      end

      private

      def user_params
        params.require(:token).permit(:email, :password)
      end
    end
  end
end
