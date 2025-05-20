require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  # before(:each) { request.headers["Accept"] = "application/vnd.marketplace.v1" }

  describe "GET /show" do
    before(:each) do
      @user = FactoryBot.create(:user)
      get :show, params: { id: @user.id }, format: :json
    end
    it "retutrns infrmation on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      (user_response[:email]).should eq @user.email
    end
  end

  describe "POST /create" do
    before(:each) do
      @user_attributes = FactoryBot.attributes_for(:user)
      post :create, params: { user: @user_attributes }, format: :json
    end
    it "returns the json for the created user" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eq @user_attributes[:email]
    end
    it { should respond_with 201 }
    context "with invalid params" do
      before(:each) do
        @invalid_user_attributes = { email: "not an email", password: "123" }
        post :create, params: { user: @invalid_user_attributes }, format: :json
      end

      it "returns a json error message" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
      it "renders json errors on the user not created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "is invalid"
      end
    end
  end

  describe "PUT/PATCH /update" do
    context "when is successfully updated" do
      before(:each) do
        @user = FactoryBot.create(:user)
        @user_attributes = FactoryBot.attributes_for(:user)
        put :update, params: { id: @user.id, user: @user_attributes }, format: :json
      end
      it "returns the json for the updated user" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @user_attributes[:email]
      end
      it { should respond_with 200 }
    end
    context "when is not successfully updated" do
      before(:each) do
        @user = FactoryBot.create(:user)
        @user_attributes = { email: "not an email", password: "123" }
        put :update, params: { id: @user.id, user: @user_attributes }, format: :json
      end
      it "returns a json error message" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders json errors on the user not updated" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "is invalid"
      end
      it { should respond_with 422 }
    end
  end
end
