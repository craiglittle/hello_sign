require 'helper'
require 'hello_sign/client'
require 'shared_examples/proxy'

describe HelloSign::Client do
  let(:email_address) { double('email_address') }
  let(:password)      { double('password') }
  subject(:hs_client) { HelloSign::Client.new(email_address, password) }

  it_behaves_like 'a proxy' do
    let(:client) { hs_client }
  end

  describe "request methods" do
    let(:path)     { double('path') }
    let(:options)  { double('options') }
    let(:response) { double('response') }

    before { allow(hs_client).to receive(:request).and_return(response) }

    describe "#get" do
      before { @response = hs_client.get(path, options) }

      it "sends a request" do
        expect(hs_client).to have_received(:request).with(:get, path, options)
      end

      it "returns the response" do
        expect(@response).to eq response
      end
    end

    describe "#post" do
      before { @response = hs_client.post(path, options) }

      it "sends a request" do
        expect(hs_client).to have_received(:request).with(:post, path, options)
      end

      it "returns the response" do
        expect(@response).to eq response
      end
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
