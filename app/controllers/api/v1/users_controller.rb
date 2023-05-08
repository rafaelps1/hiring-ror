class Api::V1::UsersController < ApplicationController
  # GET /users/1
  def show
    user = User.find_by_id(params[:id])
    render json: user and return if user.present?

    render json: { message: 'Not found' }, status: :not_found
  end

  # POST /users
  def create
    user = User.new(user_params)
    render json: user, status: :created and return if user.save
    
    render json: user.errors, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
