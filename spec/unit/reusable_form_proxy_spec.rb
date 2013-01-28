require 'helper'
require 'hello_sign/reusable_form_proxy'

describe HelloSign::ReusableFormProxy do
  let(:client)       { double('client') }
  let(:api_response) { double('API response') }
  let(:form_id)      { 'form_id' }
  subject(:rf_proxy) { HelloSign::ReusableFormProxy.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(rf_proxy.client).to be client
    end
  end

  describe "#list" do
    context "when called without options" do
      before { client.should_receive(:get).with('/reusable_form/list', :params => {:page => 1}).and_return(api_response) }

      it "fetches the first page of reusable forms and returns the result" do
        expect(rf_proxy.list).to eq api_response
      end
    end

    context "when called with a page number" do
      before { client.should_receive(:get).with('/reusable_form/list', :params => {:page => 10}).and_return(api_response) }

      it "fetches a list of reusable forms for the passed page number and returns the result" do
        expect(rf_proxy.list(:page => 10)).to eq api_response
      end
    end
  end

  describe "#show" do
    before { client.should_receive(:get).with('/reusable_form/form_id').and_return(api_response) }

    it "fetches the reusable form details and returns the result" do
      expect(rf_proxy.show(form_id)).to eq api_response
    end
  end

  describe "#grant_access" do
    let(:email)      { 'john@johnson.com' }
    let(:account_id) { '15' }

    before { client.stub(:post).and_return(api_response) }

    context "when called with an email address" do
      it "grants access to account tied to the email address" do
        client.should_receive(:post).with('/reusable_form/add_user/form_id', :body => {:email_address => email})
        rf_proxy.grant_access(form_id, :email => email)
      end

      it "returns the API response" do
        expect(rf_proxy.grant_access(form_id, :email => email)).to eq api_response
      end
    end

    context "when called with an account ID" do
      it "grants access to account tied to the account ID" do
        client.should_receive(:post).with('/reusable_form/add_user/form_id', :body => {:account_id => account_id})
        rf_proxy.grant_access(form_id, :account_id => account_id)
      end

      it "returns the API response" do
        expect(rf_proxy.grant_access(form_id, :account_id => account_id)).to eq api_response
      end
    end

    context "when called without proper parameters" do
      it "raises an argument error exception" do
        expect { rf_proxy.grant_access(form_id) }.to raise_error ArgumentError
      end
    end
  end
end
