module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show destroy]
      before_action :check_owner, only: %i[destroy]

      # GET /users/:id
      def show
        return @user if @user.present?

        head :not_found
      end

      # POST /users
      def create
        @user = User.new(user_params)
        render json: user, status: :created and return if user.save

        render json: user.errors, status: :unprocessable_entity
      end

      # DELETE /users/:id
      def destroy
        @user.destroy
        head 204
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def set_user
        @user = User.find_by_id(params[:id])
      end

      def check_owner
        head :forbidden unless @user.id == current_user&.id
      end
    end
  end
end
