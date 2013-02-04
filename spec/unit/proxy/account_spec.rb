require 'helper'
require 'hello_sign/proxy/account'

describe HelloSign::Proxy::Account do
  let(:client)            { double('client') }
  subject(:account_proxy) { HelloSign::Proxy::Account.new(client) }

  its(:client) { should eq client }

  describe "#create" do
    context "when passed the proper parameters" do
      let(:api_response) { double('API response') }

      before { client.stub(:post).and_return(api_response) }

      it "sends an account creation request" do
        client.should_receive(:post)
          .with(
            '/account/create',
            :body => {:email_address => 'david@bowman.com', :password => 'space'},
            :auth_not_required => true
          )
        account_proxy.create(:email => 'david@bowman.com', :password => 'space')
      end

      it "returns the API response" do
        expect(account_proxy.create(:email => 'david@bowman.com', :password => 'space')). to eq api_response
      end
    end

    context "when not passed the proper parameters" do
      it "raises an exception" do
        expect { account_proxy.create(:email => 'david@bowman.com') }.to raise_error
      end
    end
  end

  describe "#settings" do
    let(:settings_proxy_source) { double('settings proxy source') }
    let(:settings_proxy)        { double('settings proxy') }

    before do
      account_proxy.settings_proxy_source = settings_proxy_source
      settings_proxy_source.should_receive(:new).with(client).and_return(settings_proxy)
    end

    it "returns a signature request proxy" do
      expect(account_proxy.settings).to be settings_proxy
    end
  end
end
