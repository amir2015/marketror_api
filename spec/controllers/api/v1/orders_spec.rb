
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
end
