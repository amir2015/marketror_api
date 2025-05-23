require "rails_helper"

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }
  subject { @user }

  describe "when email is present" do
    it { should be_valid }
  end

  describe "when responding to email,password" do
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
  end
  describe "when email is not present" do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_presence_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_uniqueness_of(:token) }
  end

  describe "#generate_token" do
    let(:user) { FactoryBot.create(:user) }

    it "generates a unique token" do
      token = SecureRandom.hex(10)
      allow(Devise).to receive(:friendly_token).and_return(token)

      user.generate_token

      expect(user.token).to eql(token)
    end

    it "generates another not-taken token" do
      taken_token = SecureRandom.hex(10)
      existing_user = FactoryBot.create(:user, token: taken_token)

      allow(Devise).to receive(:friendly_token).and_return(taken_token, "new_unique_token")

      user.generate_token

      expect(user.token).not_to eql(existing_user.token)
      expect(user.token).to eql("new_unique_token")
    end
  end
end
