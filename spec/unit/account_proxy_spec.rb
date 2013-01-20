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
      before do
        client.should_receive(:post)
          .with('/v3/account/create', {:email_address => 'david@bowman.com', :password => 'space'})
      end

      it "sends an account creation request" do
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
end
