#rubocop:disable all

module Api
  module V1
    class ProductsController < ApplicationController
      def show
        @product = Product.find(params[:id])
        render json: { product: @product }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Product not found" }, status: :not_found
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
