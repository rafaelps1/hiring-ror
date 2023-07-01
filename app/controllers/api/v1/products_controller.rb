module Api
  module V1
    class ProductsController < ApplicationController
      before_action :check_login, only: :create

      # GET /products
      # GET /products?page=2&name=Ca
      def index
        product_service = ProductService.new(filter: params)
        @products = product_service.list
        @pages = product_service.pages
        @errors = product_service.errors
        render status: :bad_request and return if @errors.present?
      end

      # POST /products
      def create
        head :forbidden and return unless check_login

        product_service = ProductService.call(product_hash: product_params.to_h)
        @product = product_service.product_create(current_user.id)
        render status: :created and return if @product

        @errors = product_service.errors
        render status: :unprocessable_entity
      end

      # PATCH /products/:id
      def inactive
        product_service = ProductService.call(id: params[:id])
        render json: {} and return if product_service.inactive

        render json: { errors: I18n.t('errors.product.already_inactive') }, status: :unprocessable_entity
      end

      private

      def product_params
        params.require(:product).permit(:name, :title, :price, :photo, :state)
      end
    end
  end
end
