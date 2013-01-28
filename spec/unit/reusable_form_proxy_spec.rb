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
end
