require 'helper'
require 'hello_sign'

describe HelloSign do
  describe "::account" do
    it "returns an account proxy" do
      expect(HelloSign.account).to be_a HelloSign::AccountProxy
    end
  end

  describe "::signature_request" do
    let(:sr_proxy)       { mock }
    let(:request_result) { stub }

    before { HelloSign::SignatureRequestProxy.stub(:new).and_return(sr_proxy) }

    context "when called without passing a request ID" do
      before { sr_proxy.should_receive(:create).and_return(request_result) }

      it "calls #create on the signature request proxy and returns the result" do
        expect(HelloSign.signature_request).to eq request_result
      end
    end

    context "when called with a signature ID" do
      before { sr_proxy.should_receive(:status).with('request_id').and_return(request_result) }

      it "calls #status on the signature request proxy and returns the result " do
        expect(HelloSign.signature_request('request_id')).to eq request_result
      end
    end
  end

  describe "::client" do
    context "when it has not previously been called" do
      it "returns a new client" do
        expect(HelloSign.client).to be_a HelloSign::Client
      end
    end

    context "when it has previously been called" do
      it "returns the same client" do
        client = HelloSign.client
        expect(HelloSign.client).to be client
      end
    end
  end

  describe "::configure" do
    it "yields itself to the block" do
      HelloSign.configure do |hs|
        expect(hs).to be HelloSign
      end
    end
  end

  describe "::email" do
    it "sets and returns the email address" do
      HelloSign.email = 'hal@jupiter.com'

      expect(HelloSign.email).to eq 'hal@jupiter.com'
    end
  end

  describe "::password" do
    it "sets and returns the password" do
      HelloSign.password = 'human_domination'

      expect(HelloSign.password).to eq 'human_domination'
    end
  end
end
