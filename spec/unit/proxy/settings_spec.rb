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

    before do
      allow(client).to receive(:post).and_return(api_response)

      @response = settings.update(callback_url: callback_url)
    end

    it "sends a request to update the account's settings" do
      expect(client).to have_received(:post).with(
        '/account',
        body: {callback_url: callback_url}
      )
    end

    it "returns the API response" do
      expect(@response).to be api_response
    end
  end
end
