module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[destroy show]

      # GET /users/:id
      def show
        return @user if @user.present?

        head :not_found
      end

      # POST /users
      def create
        @user = Entity::User.new(user_params)
        render status: :created and return if @user.save

        @errors = @user.errors
        render status: :unprocessable_entity
      end

      # DELETE /users/:id
      def destroy
        head :forbidden and return unless check_login

        @errors = {}
        unless @user_record&.destroy
          @errors = { id: 100, status: 204, message: 'User not found.' }
          render status: :not_found and return
        end

        head 204
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end

      def set_user
        @user = Entity::User.fetch_by(id: params[:id])
        @user_record = @user.record if @user.present?
      end
    end
  end
end
