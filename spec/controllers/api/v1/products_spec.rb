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
      FactoryBot.create_list(:product, 5)
      get :index
    end
    it "returns a list of 5 products in json format" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:products].count).to eql(5)
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
end
