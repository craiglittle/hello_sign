require 'helper'
require 'hello_sign'

describe HelloSign do
  let(:email_address) { double('email address') }
  let(:password)      { double('password') }

  before do
    HelloSign.email_address = email_address
    HelloSign.password      = password
  end

  describe "::client" do
    let(:client) { double('client') }

    it "passes the credentials when creating the client" do
      HelloSign::Client.should_receive(:new).with(email_address, password)
      HelloSign.client
    end

    context "when it has previously been called" do
      let(:new_client) { double('new client') }

      before do
        HelloSign::Client.stub(:new).and_return(client, new_client)
        client.stub(:email_address).and_return(email_address)
        client.stub(:password).and_return(password)
        HelloSign.client
      end

      after { HelloSign.instance_variable_set(:@client, nil) }

      its(:client) { should be client }

      context "and the credentials change" do
        before do
          HelloSign.email_address = 'bob@earth.com'
          HelloSign.password      = 'being_human'
        end

        its(:client) { should be new_client }
      end
    end
  end

  context "when calling delegated methods" do
    let(:client)        { double('client') }

    before { HelloSign::Client.stub(:new).and_return(client) }

    after { HelloSign.instance_variable_set(:@client, nil) }

    it "delegates ::account to the client" do
      client.should_receive(:account)
      HelloSign.account
    end

    it "delegates ::signature_request to the client" do
      client.should_receive(:signature_request)
      HelloSign.signature_request
    end

    it "delegates ::reusable_form to the client" do
      client.should_receive(:reusable_form)
      HelloSign.reusable_form
    end

    it "delegates ::team to the client" do
      client.should_receive(:team)
      HelloSign.team
    end

    it "delegates ::unclaimed_draft to the client" do
      client.should_receive(:unclaimed_draft)
      HelloSign.unclaimed_draft
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
