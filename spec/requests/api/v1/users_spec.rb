require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  # before(:each) { request.headers["Accept"] = "application/vnd.marketplace.v1" }

  describe "GET /show" do
    before(:each) do
      @user = FactoryBot.create(:user)
      binding.pry
      get :show, params: { id: @user.id }, format: :json
    end
    it "retutrns infrmation on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      (user_response[:email]).should eq @user.email
    end
  end
end
