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

    before { allow(HelloSign::Client).to receive(:new) }

    context "when it has not previously been called" do
      before { HelloSign.client }

      it "passes the credentials when creating the client" do
        expect(HelloSign::Client).to(
          have_received(:new).with(email_address, password)
        )
      end
    end

    context "when it has previously been called" do
      let(:new_client) { double('new client') }

      before do
        allow(HelloSign::Client).to receive(:new).and_return(client, new_client)
        allow(client).to receive(:email_address).and_return(email_address)
        allow(client).to receive(:password).and_return(password)

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
    let(:client) { double('client') }

    before { allow(HelloSign::Client).to receive(:new).and_return(client) }

    after { HelloSign.instance_variable_set(:@client, nil) }

    describe "::account" do
      before do
        allow(client).to receive(:account)

        HelloSign.account
      end

      it "delegates to the client" do
        expect(client).to have_received(:account)
      end
    end

    describe "::signature_request" do
      before do
        allow(client).to receive(:signature_request)

        HelloSign.signature_request
      end

      it "delegates ::signature_request to the client" do
        expect(client).to have_received(:signature_request)
      end
    end

    describe "::reusable_form" do
      before do
        allow(client).to receive(:reusable_form)

        HelloSign.reusable_form
      end

      it "delegates ::reusable_form to the client" do
        expect(client).to have_received(:reusable_form)
      end
    end

    describe "::team" do
      before do
        allow(client).to receive(:team)

        HelloSign.team
      end

      it "delegates ::team to the client" do
        expect(client).to have_received(:team)
      end
    end

    describe "::unclaimed_draft" do
      before do
        allow(client).to receive(:unclaimed_draft)

        HelloSign.unclaimed_draft
      end

      it "delegates ::unclaimed_draft to the client" do
        expect(client).to have_received(:unclaimed_draft)
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
