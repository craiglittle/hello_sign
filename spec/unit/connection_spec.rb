require 'helper'
require 'hello_sign/connection'

describe HelloSign::Connection do
  let(:response)   { double('response') }

  subject(:connection) { HelloSign::Connection.new }

  before { allow(connection).to receive(:request).and_return(response) }

  describe "#get" do
    before { @response = connection.get('/path', options: 'hash') }

    it "sends a request" do
      expect(connection).to(
        have_received(:request).with(:get, '/path', options: 'hash')
      )
    end

    it "returns the response" do
      expect(@response).to eq response
    end
  end

  describe "#post" do
    before { @response = connection.post('/path', options: 'hash') }

    it "sends a request" do
      expect(connection).to(
        have_received(:request).with(:post, '/path', options: 'hash')
      )
    end

    it "returns the response" do
      expect(@response).to eq response
    end
  end
end
