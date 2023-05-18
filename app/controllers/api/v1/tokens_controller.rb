module Api
  module V1
    class TokensController < ApplicationController
      # POST /tokens
      def create
        @user = User.find_by_email(user_params[:email])
        if @user&.authenticate(user_params[:password])
          @token = JsonWebToken.encode(user_id: @user.id)
          @email = @user.email
          return
        end

        head :unauthorized
      end

      private

      def user_params
        params.require(:token).permit(:email, :password)
      end
    end
  end
end
