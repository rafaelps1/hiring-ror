module Api
  module V1
    class UsersController < ApplicationController
      before_action :call_user_service, only: %i[destroy show]

      # GET /users/:id
      def show
        return @user if @user.present?

        head :not_found
      end

      # POST /users
      def create
        user_service = UserService.call(user_hash: user_params.to_h)
        if user_service.valid?
          user_service.save
          @user = user_service.result
          render status: :created and return
        end

        @errors = user_service.errors
        render status: :unprocessable_entity
      end

      # DELETE /users/:id
      def destroy
        head :forbidden and return unless check_login

        @errors = {}
        unless @user_service.destroy
          @errors = { id: 100, status: 204, message: 'User not found.' }
          render status: :not_found and return
        end

        head 204
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end

      def call_user_service
        @user_service = UserService.call(id: params[:id])
        @user = @user_service.result
      end
    end
  end
end
