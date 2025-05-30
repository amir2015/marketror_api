# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET /index" do
    before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)
      FactoryBot.create_list(:order, 4, user: current_user)
      get :index, params: { user_id: current_user.id }, format: :json
    end
    it "returns response of 4 orders from the current-user" do
      orders_response = JSON.parse(response.body, symbolize_names: true)
      expect(orders_response[:orders].count).to eq(4)
    end
    it { should respond_with 200 }
  end
  describe "GET #show" do
    before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)
      @order = FactoryBot.create(:order, user: current_user)
      get :show, params: { user_id: current_user.id, id: @order.id }, format: :json
    end
    it "returns the order with the sent id from the current-user" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      order_response = json_response[:order]
      expect(order_response[:id]).to eq(@order.id)
    end
    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)

      product1 = FactoryBot.create(:product)
      product2 = FactoryBot.create(:product)
      order_params = { user_id: current_user.id, product_ids: [product1.id, product2.id] }
      post :create, params: { user_id: current_user.id, order: order_params }, format: :json
      puts response.body
    end
    it "returns the created order" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:order]).to have_key(:id)
    end
    it { should respond_with 201 }
  end

  describe "#set_total" do
    before(:each) do
      product_1 = FactoryBot.create(:product, price: 10)
      product_2 = FactoryBot.create(:product, price: 20)
      @order = FactoryBot.build(:order, product_ids: [product_1.id, product_2.id])
    end
    it "returns the total of the order" do
      expect { @order.set_total }.to change { @order.total }.from(0).to(30)
    end
  end
end
