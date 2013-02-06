require 'helper'
require 'hello_sign/proxy/account'

describe HelloSign::Proxy::Account do
  let(:client)            { double('client') }
  let(:api_response)      { double('API response') }
  subject(:account_proxy) { HelloSign::Proxy::Account.new(client) }

  its(:client) { should eq client }

  describe "#create" do

    let(:email_address) { 'david@bowman.com' }
    let(:password)      { 'password' }

    before { client.stub(:post).and_return(api_response) }

    it "sends a request to create an account" do
      client.should_receive(:post).with(
        '/account/create',
        :body => {:email_address => 'david@bowman.com', :password => 'space'},
        :auth_not_required => true
      )
      account_proxy.create(
        :email_address => 'david@bowman.com',
        :password      => 'space'
      )
    end

    it "returns the API response" do
      expect(
        account_proxy.create(
          :email_address => 'david@bowman.com',
          :password      => 'space'
        )
      ). to eq api_response
    end

  end

  describe "#settings" do

    let(:settings_proxy_source) { double('settings proxy source') }
    let(:settings_proxy)        { double('settings proxy') }

    before do
      account_proxy.settings_proxy_source = settings_proxy_source
    end

    it "returns a signature request proxy" do
      settings_proxy_source.should_receive(:new)
        .with(client)
        .and_return(settings_proxy)
      expect(account_proxy.settings).to be settings_proxy
    end

  end
end
