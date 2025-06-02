#rubocop:disable all
require "rails_helper"

RSpec.describe Order, type: :model do
  let!(:order) { FactoryBot.build(:order) }
  subject { order }
  describe "responding to" do
    it { should respond_to(:total) }
    it { should respond_to(:user_id) }
  end
  describe "validations" do
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  end
  describe "associations" do
    it { should belong_to(:user) }
  end
  describe "associations" do
    it { should have_many(:placements) }
    it { should have_many(:products).through(:placements) }
    it { should belong_to(:user) }
  end
  describe "#build_placements_with_products_ids_and_quantities" do

  let!(:product1) { FactoryBot.create(:product, price: 100, quantity: 5) }
  let!(:product2) { FactoryBot.create(:product, price: 85, quantity: 10) }
  let!(:product_ids_quantities) { [[product1.id, 2], [product2.id, 3]] }

    it "builds 2 placements for the order" do
      expect {
        order.build_placements_with_products_ids_and_quantities(product_ids_quantities)
      }.to change { order.placements.size }.from(0).to(2)
    end
  end
end
