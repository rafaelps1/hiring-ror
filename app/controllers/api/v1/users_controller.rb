module Api
  module V1
    class UsersController < ApplicationController
      # GET /users/:id
      def show
        result = UserService.new.call(id: params[:id]).show_user
        @user = result.success and return if result.success?

        @errors = [result.failure]
        render status: :not_found
      end

      # POST /users
      def create
        result = UserService.new.call(user_hash: user_params.to_h).create_user
        @user = result.success
        render status: :created and return if result.success?

        @errors = result.failure
        render status: :unprocessable_entity
      end

      # DELETE /users/:id
      def destroy
        head :forbidden and return unless check_login

        result = UserService.new.call(id: params[:id]).destroy
        if result.failure?
          @errors = [result.failure]
          render status: :not_found and return
        end

        head 204
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
