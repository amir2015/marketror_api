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
end
