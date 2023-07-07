module Api
  module V1
    class ProductsController < ApplicationController
      # GET /products
      # GET /products?page=2&name=Ca
      def index
        products = ProductService.new.call(filter: params).list
        if products.failure?
          @errors = products.failure
          render status: :bad_request and return
        end

        @products, @pages = products.success
      end

      # POST /products
      def create
        head :forbidden and return unless check_login

        new_product = ProductService.new.call(product_hash: product_params.to_h,
                                              user_id: current_user.id).create_product
        if new_product.failure?
          @errors = new_product.failure
          render status: :unprocessable_entity and return
        end

        @product = new_product.success
        render status: :created
      end

      # PUT /products/:id
      def inactive
        result = ProductService.new.call(id: params[:id]).inactive
        render status: :ok and return if result.success?

        @errors = [{ id: 10, title: I18n.t('errors.product.already_inactive'), status: 422 }]
        render status: :unprocessable_entity and return if result.failure?
      end

      private

      def product_params
        params.require(:product).permit(:name, :title, :price, :photo, :state)
      end
    end
  end
end
