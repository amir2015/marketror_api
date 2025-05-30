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
    order = current_user.orders.build(order_params)

    render json: { order: order }, status: :created

    render json: { errors: order.errors }, status: :unprocessable_entity unless order.save
  end

  private

  def order_params
    params.require(:order).permit(:total, :user_id, product_ids: [])
  end
end
