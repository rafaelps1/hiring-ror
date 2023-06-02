module Api
  module V1
    class ProductsController < ApplicationController
      before_action :check_login, only: :create

      # GET /products
      # GET /products?page=2&name=Ca
      def index
        @products = repository.index(params) || []
        @pages = repository.pages
        @errors = repository.errors

        render json: { errors: @errors.message }, status: :bad_request if @errors.present?
      end

      # POST /products
      def create
        product = current_user.products.build(product_params)
        if product.save
          render json: product, status: :created
        else
          render json: { errors: product.errors }, status: :unprocessable_entity
        end
      end

      # PATCH /products/:id
      def inactive
        render json: {} and return if repository.inactive(params[:id])

        render json: { errors: I18n.t('errors.product.already_inactive') }, status: :unprocessable_entity
      end

      private

      def product_params
        params.require(:product).permit(:name, :title, :price, :photo, :state)
      end

      def repository
        @repository ||= ProductRepository.new(model: Entity::Product, record: ProductRecord)
      end
    end
  end
end
