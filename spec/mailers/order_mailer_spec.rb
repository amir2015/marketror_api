require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  include Rails.application.routes.url_helpers
  describe ".send_confirmation" do
    before(:all) do
      @order = FactoryBot.create(:order)
      @user = @order.user
      @order_mailer = OrderMailer.send_confirmation(@order)
    end
    it "should send an email and set to be deilvered to the email in order" do
      expect(@order_mailer).to deliver_to(@user.email)
    end
    it "should to be set to be send from no-reply@example.com" do
      expect(@order_mailer).to deliver_from("no-reply@example.com")
    end
    it "should have the right message in the email body" do
      expect(@order_mailer).to have_body_text(/Order: #{@order.id}/)
    end
    it "does have the product count" do
      expect(@order_mailer).to have_body_text(/You ordered #{@order.products.count} products/)
    end
    it "does have the correct subject" do
      expect(@order_mailer).to have_subject("Order Confirmation ##{@order.id}")
    end
  end
end
