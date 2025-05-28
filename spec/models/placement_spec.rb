#rubocop:disable all
require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

end
