module Api
  module V1
    class ProductsController < ApplicationController
      # before_action :set_filter_params, only: :index
      before_action :set_product, only: %i[update inactive]
      before_action :check_login, only: :create

      # GET /products
      def index
        # TODO: add this code block on products service.
        # And add repository in the service too.
        # So, it improvements design (software) and help code maintainable

        page      = params[:page] || 1
        term      = params[:term]
        filtered  = Product.active
        filtered  = filtered.filter_by_name(term) if term.present?

        @pagy, @products = pagy(filtered.order(:created_at), page: page)
      end

      # POST /products
      def create
        # TODO: add this code block on products service.
        # And add repository in the service too.
        # So, it improvements design (software) and help code maintainable

        product = current_user.products.build(product_params)
        if product.save
          render json: product, status: :created
        else
          render json: { errors: product.errors }, status: :unprocessable_entity
        end
      end

      # PATCH /products/:id
      def inactive
        # TODO: add this code block on products service.
        # And add repository in the service too.
        # So, it improvements design (software) and help code maintainable

        if @product.state
          @product.update(state: false)
          render json: @product and return
        end

        render json: { error: 'Product already inactive.' }, status: :unprocessable_entity
      end

      private

      def product_params
        params.require(:product).permit(:name, :title, :price, :photo, :state)
      end

      # def set_filter_params
      #   params.require(:product).permit(:term, :page)
      # end

      def set_product
        @product = Product.find_by_id(params[:id])
      end
    end
  end
end
