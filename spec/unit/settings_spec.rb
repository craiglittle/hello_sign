require 'helper'
require 'hello_sign/settings'

describe HelloSign::Settings do
  let(:attributes)   { double('attributes') }
  let(:client)       { double('client') }
  subject(:settings) { HelloSign::Settings.new(attributes, client) }

  describe "#attributes" do
    it "returns the attributes" do
      expect(settings.attributes).to eq attributes
    end
  end

  describe "#client" do
    it "returns the client" do
      expect(settings.client).to eq client
    end
  end

  describe "#update" do
    let(:callback_url) { 'http://www.callmemaybe.com' }

    before { client.stub(:post) }

    it "sends a request to update the account's settings" do
      client.should_receive(:post)
        .with('/account', :body => {:callback_url => callback_url})
      settings.update(:callback_url => callback_url)
    end

    it "returns true" do
      expect(settings.update(:callback_url => callback_url)).to be true
    end
  end
end
