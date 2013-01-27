require 'helper'
require 'hello_sign'

describe HelloSign do
  describe "::account" do
    it "returns an account proxy" do
      expect(HelloSign.account).to be_a HelloSign::AccountProxy
    end
  end

  describe "::signature_request" do
    it "returns a signature request proxy" do
      expect(HelloSign.signature_request).to be_a HelloSign::SignatureRequestProxy
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
