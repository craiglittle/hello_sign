require 'integration/helper'

describe HelloSign do
  context "when creating an account" do
    before do
      stub_request(:post, 'https://api.hellosign.com/v3/account/create')
      HelloSign.account.create(:email => 'david@bowman.com', :password => 'foobar')
    end

    it "sends an account creation request to the HelloSign API" do
      a_request(:post, 'https://api.hellosign.com/v3/account/create')
        .with(:body => {:email_address => 'david@bowman.com', :password => 'foobar'})
        .should have_been_made
    end
  end
end
