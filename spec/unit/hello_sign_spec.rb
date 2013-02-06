require 'helper'
require 'hello_sign'

describe HelloSign do
  before do
    HelloSign.email_address = 'hal@jupiter.com'
    HelloSign.password      = 'human_domination'
  end

  its(:email_address) { should eq 'hal@jupiter.com' }
  its(:password)      { should eq 'human_domination' }

  describe "::client" do
    context "when it has not previously been called" do
      it "returns a new client" do
        expect(HelloSign.client).to be_a HelloSign::Client
      end
    end

    context "when it has previously been called" do
      before { @client = HelloSign.client }

      it "returns the same client" do
        expect(HelloSign.client).to be @client
      end

      context "and the email and password changes" do
        before do
          HelloSign.email_address = 'bob@earth.com'
          HelloSign.password      = 'being_human'
        end

        it "creates a new client with the new credentials" do
          expect(HelloSign.client).to_not be @client
          expect(HelloSign.client.email_address).to eq 'bob@earth.com'
          expect(HelloSign.client.password).to eq 'being_human'
        end
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
end
