require 'helper'
require 'hello_sign'

describe HelloSign do
  let(:email_address) { double('email address') }
  let(:password)      { double('password') }

  before do
    HelloSign.email_address = email_address
    HelloSign.password      = password
  end

  its(:email_address) { should eq email_address }
  its(:password)      { should eq password }

  describe "::client" do
    let(:client_source) { double('client_source') }
    let(:client)        { double('client') }

    before do
      HelloSign._set_internal_collaborator(:client_source, client_source)
      client_source.stub(:new).and_return(client)
    end

    after { HelloSign.instance_variable_set(:@client, nil) }

    its(:client) { should be client }

    it "passes the credentials when creating the client" do
      client_source.should_receive(:new).with(email_address, password)
      HelloSign.client
    end

    context "when it has previously been called" do
      let(:new_client) { double('new client') }

      before do
        client_source.stub(:new).and_return(client, new_client)
        client.stub(:email_address).and_return(email_address)
        client.stub(:password).and_return(password)
        HelloSign.client
      end

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
    let(:client_source) { double('client_source') }
    let(:client)        { double('client') }

    before do
      HelloSign._set_internal_collaborator(:client_source, client_source)
      client_source.stub(:new).and_return(client)
    end

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
