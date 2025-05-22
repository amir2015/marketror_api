# rubocop:disable all
require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "POST #create" do
    let!(:user) { FactoryBot.create(:user, password: "password123", password_confirmation: "password123") }

    context "when credentials are correct" do
      before(:each) do
        credentials = { email: user.email, password: "password123" }
        post :create, params: { session: credentials }
      end

      it "returns the user record corresponding to the given credentials" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:token]).to eql(user.reload.token)
      end

      it { is_expected.to respond_with 200 }
    end

    context "when the credentials are incorrect" do
      before(:each) do
        credentials = { email: user.email, password: "wrong_password" }
        post :create, params: { session: credentials }
      end

      it "returns a json with an error" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:error]).to eql "Invalid email or password"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      delete :destroy, params: { id: @user.token }
    end
    it { should respond_with 204 }
  end
end
