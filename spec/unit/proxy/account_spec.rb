require 'helper'
require 'hello_sign/proxy/account'

describe HelloSign::Proxy::Account do
  let(:client)            { double('client') }
  let(:api_response)      { double('API response') }
  subject(:account_proxy) { HelloSign::Proxy::Account.new(client) }

  describe "#create" do
    let(:email_address) { 'david@bowman.com' }
    let(:password)      { 'password' }

    before do
      allow(client).to receive(:post).and_return(api_response)

      account_proxy.create(
        email_address: 'david@bowman.com',
        password:      'space'
      )
    end

    it "sends a request to create an account" do
      expect(client).to have_received(:post).with(
        '/account/create',
        body: {email_address: 'david@bowman.com', password: 'space'},
        auth_not_required: true
      )
    end

    it "returns the API response" do
      expect(
        account_proxy.create(
          email_address: 'david@bowman.com',
          password:      'space'
        )
      ).to eq api_response
    end
  end

  describe "#settings" do
    let(:settings_proxy) { double('settings proxy') }

    before do
      allow(HelloSign::Proxy::Settings).to(
        receive(:new).with(client).and_return(settings_proxy)
      )
    end

    it "returns a signature request proxy" do
      expect(account_proxy.settings).to be settings_proxy
    end
  end
end
