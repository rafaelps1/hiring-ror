module Api
  module V1
    class TokensController < ApplicationController
      # POST /tokens
      def generate
        token_service = LoginTokenService.call(user_params[:email], user_params[:password])
        @result = token_service.result and return if token_service.logged?

        head :unauthorized
      end

      private

      def user_params
        params.require(:token).permit(:email, :password)
      end
    end
  end
end
