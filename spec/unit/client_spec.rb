require 'helper'
require 'hello_sign/client'
require 'shared_examples/proxy'

describe HelloSign::Client do
  let(:email_address) { double('email_address') }
  let(:password)      { double('password') }
  subject(:hs_client) { HelloSign::Client.new(email_address, password) }

  its(:email_address) { should eq email_address }
  its(:password)      { should eq password }

  it_behaves_like 'a proxy' do
    let(:client) { hs_client }
  end

  describe "request methods" do
    let(:path)     { double('path') }
    let(:options)  { double('options') }
    let(:response) { double('response') }

    before { hs_client.stub(:request).and_return(response) }

    describe "#get" do
      it "sends a request" do
        hs_client.should_receive(:request).with(:get, path, options)
        hs_client.get(path, options)
      end

      it "returns the response" do
        expect(hs_client.get(path, options)).to eq response
      end
    end

    describe "#post" do
      it "sends a request" do
        hs_client.should_receive(:request).with(:post, path, options)
        hs_client.post(path, options)
      end

      it "returns the response" do
        expect(hs_client.post(path, options)).to eq response
      end
    end
  end

  context "when a hash is passed to the constructor" do
    subject(:hs_client) { HelloSign::Client.new(:email_address => email_address, :password => password) }

    its(:email_address) { should eq email_address }
    its(:password)      { should eq password }

    it "raises an exception if an email address is not provided" do
      expect { HelloSign::Client.new(:password => 'space') }.to raise_error ArgumentError
    end

    it "raises an exception if a password is not provided" do
      expect { HelloSign::Client.new(:email_address => 'david@bowman.com') }.to raise_error ArgumentError
    end
  end
end
