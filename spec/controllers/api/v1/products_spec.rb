#rubocop:disable all
require "rails_helper"

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @product = FactoryBot.create(:product)
      get :show, params: { id: @product.id }
    end
    it "returns the product in json format" do
      json_response = JSON.parse(response.body, symbolize_names: true)

      product_response = json_response[:product]
      expect(product_response[:title]).to eq(@product.title)
    end
    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryBot.create(:user)
      FactoryBot.create_list(:product, 5, user: user)
      get :index
    end
    it "returns a list of 5 products in json format" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:products].count).to eql(5)
    end
    it "returns the user objeact into each product" do
      product_response = JSON.parse(response.body, symbolize_names: true)
      product_response[:products].each do |product|
        expect(product[:user]).to be_present
      end
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when successfully created" do
      before(:each) do
        user = FactoryBot.create(:user)
        @product_attributes = FactoryBot.attributes_for(:product)
        api_authorization_header user.token
        post :create, params: { user_id: user.id, product: @product_attributes }
      end
      it "returns the json for the created product" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:product][:title]).to eq(@product_attributes[:title])
      end
      it { is_expected.to respond_with 201 }
    end
    context "when product is not created" do
      before (:each) do
        user = FactoryBot.create(:user)
        @invalid_product_attributes = FactoryBot.attributes_for(:product, title: nil)
        api_authorization_header user.token
        post :create, params: { user_id: user.id, product: @invalid_product_attributes }
      end
      it "returns the json for the errors" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors][:title]).to include("can't be blank")
      end
      it { is_expected.to respond_with 422 }
    end
  end

  describe "Put/PATCH #update" do
    before(:each) do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user: @user)
      api_authorization_header @user.token
    end
    context "when successfully updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @product.id, product: { title: "Updated Title" } }
      end
      it "render the json representation for the updated product" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:product][:title]).to eq("Updated Title")

      end
      it { is_expected.to respond_with 200 }
    end
    context "when product is not updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @product.id, product: { price: "5dollars" } }
      end
      it "returns the json for the errors" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors][:price]).to include("is not a number")
      end
      it { is_expected.to respond_with 422 }
    end
  end

  describe "a specification" do
    before(:each) do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user: @user)
      api_authorization_header @user.token
      delete :destroy, params: { user_id: @user.id, id: @product.id }
    end
  end
end
