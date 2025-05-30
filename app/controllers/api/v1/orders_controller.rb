class Api::V1::OrdersController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  before_action :authenticate_with_token, only: [:index]
  respond_to :json

  def index
    respond_with orders: current_user.orders
  end

  def show
    respond_with order: current_user.orders.find(params[:id])
  end
end
