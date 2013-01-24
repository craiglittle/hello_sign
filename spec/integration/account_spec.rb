require 'integration/helper'


describe HelloSign do
  context "when creating an account" do
    before do
      stub_post('/account/create')
      HelloSign.account.create(:email => 'david@bowman.com', :password => 'foobar')
    end

    it "sends an account creation request to the HelloSign API" do
      expect(a_post('/account/create')
        .with(:body => {:email_address => 'david@bowman.com', :password => 'foobar'}))
        .to have_been_made
    end
  end

  context "when accessing an account's settings" do
    before do
      stub_get_with_auth('/account')
      @settings = HelloSign.account.settings
    end

    it "fetches the account's settings from the HelloSign API" do
      expect(a_get_with_auth('/account')).to have_been_made
    end
  end

  context "when updating an account's settings" do
    before do
      stub_get_with_auth('/account')
      stub_post_with_auth('/account')
      HelloSign.account.settings.update(:callback_url => 'http://callmemaybe.com')
    end

    it "sends an update account request to the HelloSign API" do
      expect(a_post_with_auth('/account')
        .with(:body => {:callback_url => 'http://callmemaybe.com'}))
        .to have_been_made
    end
  end
end
