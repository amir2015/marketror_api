require "rails_helper"

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build(:product) }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:description) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }
  # it { should not_be_published }
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to(:user).optional }
  end
  describe ".by_title" do
    before(:each) do
      @product1 = FactoryBot.create(:product, title: "Apple pods")
      @product4 = FactoryBot.create(:product, title: "Apple Mac")
      @product2 = FactoryBot.create(:product, title: "Samsung")
      @product3 = FactoryBot.create(:product, title: "Dell")
    end
    context "an apple pattern is given " do
      it "returns an array of 2 products" do
        expect(Product.by_title("apple").count).to eq(2)
      end

      it "returns 2 products matching the pattern" do
        expect(Product.by_title("apple").sort).to match_array([@product1, @product4])
      end
    end
  end
end
