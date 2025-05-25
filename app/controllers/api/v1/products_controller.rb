#rubocop:disable all

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :authenticate_with_token, only: [:create]

      def show
        @product = Product.find(params[:id])
        render json: { product: @product }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Product not found" }, status: :not_found
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def index
        render json:  Product.all, status: :ok
      end

      def create
        product = current_user.products.build(product_params)
        if product.save
          render json: { product: product }, status: :created, location: [:api, product]
        else
          render json: { errors: product.errors }, status: 422
        end
      end

      def update
        product = Product.find(params[:id])
        if product.update(product_params)
          render json: product, status: 200, location: [:api, product]
        else
          render json: { errors: product.errors }, status: 422
        end
      end

      def destroy
        product = Product.find(params[:id])
        product.destroy
        head :no_content
      end

      private

      def product_params
        params.require(:product).permit(:title, :description, :price, :stock)
      end
    end
  end
end
