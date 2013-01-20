require 'helper'
require 'hello_sign/account_proxy'

describe HelloSign::AccountProxy do
  let(:client)            { double('client') }
  subject(:account_proxy) { HelloSign::AccountProxy.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(account_proxy.client).to be client
    end
  end

  describe "#create" do
    context "when passed the proper parameters" do
      before { client.stub(:post) }

      it "sends an account creation request" do
        client.should_receive(:post)
          .with(
            '/account/create',
            :body => {:email_address => 'david@bowman.com', :password => 'space'},
            :unauthenticated => true
          )
        account_proxy.create(:email => 'david@bowman.com', :password => 'space')
      end

      it "returns true" do
        expect(account_proxy.create(:email => 'david@bowman.com', :password => 'space')). to be true
      end
    end

    context "when not passed the proper parameters" do
      it "raises an exception" do
        expect { account_proxy.create(:email => 'david@bowman.com') }.to raise_error
      end
    end
  end

  describe "#settings" do
    let(:settings) { double('settings') }

    before { client.stub(:get).and_return(settings) }

    it "sends a request to fetch the account's settings" do
      client.should_receive(:get).with('/account')
      account_proxy.settings
    end

    it "returns the response" do
      expect(account_proxy.settings).to eq settings
    end
  end
end
