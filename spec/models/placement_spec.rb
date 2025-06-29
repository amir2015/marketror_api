#rubocop:disable all
require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end
describe "respond_to" do
  it { should respond_to(:order_id)}
  it { should respond_to(:product_id)}
end

end
