class Api::V1::OrdersController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren,Style/FrozenStringLiteralComment
  before_action :authenticate_with_token, only: [:index]
  respond_to :json

  def index
    respond_with orders: current_user.orders
  end

  def show
    respond_with order: current_user.orders.find(params[:id])
  end

  def create
    order = current_user.orders.build

    order.build_placements_with_products_ids_and_quantities(
      params[:order][:product_ids_and_quantities]
    )

    return render json: { errors: order.errors }, status: 422 unless order.save

    order.reload
    OrderMailer.send_confirmation(order).deliver_now
    render json: { order: order, products: order.products }, status: 201
  end

  private

  def order_params
    params.require(:order).permit(:user_id, product_ids: [])
  end
end
