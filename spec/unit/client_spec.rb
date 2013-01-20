require 'helper'
require 'hello_sign/client'

describe HelloSign::Client do
  subject(:client) { HelloSign::Client.new('david@bowman.com', 'space') }

  describe "#email" do
    it "returns the email address" do
      expect(client.email).to eq 'david@bowman.com'
    end
  end

  describe "#password" do
    it "returns the password" do
      expect(client.password).to eq 'space'
    end
  end

  describe "#post" do
    let(:connection) { double('connection') }

    before do
      client.connection = connection
      connection.should_receive(:post).with('path', 'body')
    end

    it "sends a POST request with the connection" do
      client.post('path', 'body')
    end
  end
end
