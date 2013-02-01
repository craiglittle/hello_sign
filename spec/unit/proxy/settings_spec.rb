require 'helper'
require 'hello_sign/proxy/settings'

describe HelloSign::Proxy::Settings do
  let(:client)       { double('client') }
  subject(:settings) { HelloSign::Proxy::Settings.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(settings.client).to eq client
    end
  end

  describe "#update" do
    let(:callback_url) { 'http://www.callmemaybe.com' }
    let(:api_response) { double('API response') }

    before { client.stub(:post).and_return(api_response) }

    it "sends a request to update the account's settings" do
      client.should_receive(:post).with('/account', :body => {:callback_url => callback_url})
      settings.update(:callback_url => callback_url)
    end

    it "returns the API response" do
      expect(settings.update(:callback_url => callback_url)).to be api_response
    end
  end
end
