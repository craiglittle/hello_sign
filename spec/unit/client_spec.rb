require 'helper'
require 'hello_sign/client'
require 'shared_examples/proxy'

describe HelloSign::Client do
  let(:connection) { double('connection') }
  let(:response)   { double('response') }

  subject(:hs_client) { HelloSign::Client.new('email address', 'password') }

  it_behaves_like 'a proxy' do
    let(:client) { hs_client }
  end

  before do
    allow(HelloSign::Connection).to receive(:new).and_return(connection)
  end

  describe "#get" do
    before do
      allow(connection).to receive(:get).and_return(response)

      @response = hs_client.get('/path', options: 'hash')
    end

    it "delegates to the connection" do
      expect(connection).to have_received(:get).with('/path', options: 'hash')
    end

    it "returns the response" do
      expect(@response).to eq response
    end
  end

  describe "#post" do
    before do
      allow(connection).to receive(:post).and_return(response)

      @response = hs_client.post('/path', options: 'hash')
    end

    it "delegates to the connection" do
      expect(connection).to(
        have_received(:post).with('/path', options: 'hash')
      )
    end

    it "returns the response" do
      expect(@response).to eq response
    end
  end

  context "when a hash is passed to the constructor" do
    subject(:hs_client) do
      HelloSign::Client.new(email_address: email_address, password: password)
    end

    it "raises an exception if an email address is not provided" do
      expect { HelloSign::Client.new(password: 'space') }.to(
        raise_error ArgumentError
      )
    end

    it "raises an exception if a password is not provided" do
      expect { HelloSign::Client.new(email_address: 'david@bowman.com') }.to(
        raise_error ArgumentError
      )
    end
  end
end
