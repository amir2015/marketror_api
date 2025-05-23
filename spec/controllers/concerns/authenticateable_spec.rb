#rubocop:disable all
require "rails_helper"

class Authentication< ActionController::API
  include Authenticateable
end

describe Authenticateable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryBot.create(:user)
      request.headers["Authorization"]=@user.token
      authentication.stub(:request).and_return(request)
    end

    it"returns the user from the authorization header"do
    expect(authentication.current_user.token).to eql(@user.token)
  end
  end







  

end
