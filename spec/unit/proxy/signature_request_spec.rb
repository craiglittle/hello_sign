require 'helper'
require 'hello_sign/proxy/signature_request'

describe HelloSign::Proxy::SignatureRequest do
  let(:client)       { double('client') }
  let(:request_id)   { 'request_id' }
  let(:api_response) { double('API response') }
  subject(:sr_proxy) { HelloSign::Proxy::SignatureRequest.new(client) }

  its(:client) { should eq client }

  describe "#deliver" do
    let(:formatted_request_body) { double('formatted request body') }
    let(:request_parameters)     { double('request parameters') }

    before do
      request_parameters.stub(:foo=)
      request_parameters.stub(:formatted).and_return(formatted_request_body)
      sr_proxy.request_parameters = request_parameters

      client.stub(:post).and_return(api_response)
    end

    it "yields the request parameters to the block" do
      request_parameters.should_receive(:foo=).with('bar')
      sr_proxy.deliver { |params| params.foo = 'bar' }
    end

    it "sends a signature request" do
      client.should_receive(:post)
        .with('/signature_request/send', :body => formatted_request_body)
      sr_proxy.deliver { |params| params.foo = 'bar' }
    end

    it "returns the response" do
      expect(sr_proxy.deliver {}).to eq api_response
    end

    context "when a reusable form is specified" do
      before do
        request_parameters.stub(:reusable_form_id=)
        sr_proxy.reusable_form_request_parameters = request_parameters
      end

      it "sets the reusable form ID in the request parameters" do
        request_parameters.should_receive(:reusable_form_id=).with('form_id')
        sr_proxy.deliver(:form => 'form_id') {}
      end

      it "sends a reusable form signature request" do
        client.should_receive(:post)
          .with('/signature_request/send_with_reusable_form', :body => formatted_request_body)
        sr_proxy.deliver(:form => 'form_id') {}
      end

      it "returns the response" do
        expect(sr_proxy.deliver(:form => 'form_id') {}).to eq api_response
      end
    end
  end

  describe "#status" do
    it "fetches the signature request status" do
      client.should_receive(:get)
        .with('/signature_request/request_id')
      sr_proxy.status(request_id)
    end

    it "returns the response" do
      client.stub(:get).and_return(api_response)
      expect(sr_proxy.status(request_id)).to eq api_response
    end
  end

  describe "#list" do
    context "when called without a page number" do
      it "fetches the first page of signature requests" do
        client.should_receive(:get)
          .with('/signature_request/list', :params => {:page => 1})
        sr_proxy.list
      end

      it "returns the response" do
        client.stub(:get).and_return(api_response)
        expect(sr_proxy.list).to eq api_response
      end
    end

    context "when called with a page number" do
      it "fetches a list of signature requests from the specified page" do
        client.should_receive(:get)
          .with('/signature_request/list', :params => {:page => 10})
        sr_proxy.list(:page => 10)
      end

      it "returns the response" do
        client.stub(:get).and_return(api_response)
        expect(sr_proxy.list(:page => 10)).to eq api_response
      end
    end
  end

  describe "#remind" do
    let(:email) { 'john@johnson.com' }

    it "sends a signature request reminder" do
      client.should_receive(:post)
        .with('/signature_request/remind/request_id', :body => {:email_address => email})
      sr_proxy.remind(request_id, :email => email)
    end

    it "returns the response" do
      client.stub(:post).and_return(api_response)
      expect(sr_proxy.remind(request_id, :email => email)).to eq api_response
    end

    context "when called without an email address" do
      it "raises an exception" do
        expect { sr_proxy.remind(request_id) }.to raise_error ArgumentError
      end
    end
  end

  describe "#cancel" do
    it "cancels a signature request" do
      client.should_receive(:post)
        .with('/signature_request/cancel/request_id')
      sr_proxy.cancel(request_id)
    end

    it "returns the response" do
      client.stub(:post).and_return(api_response)
      expect(sr_proxy.cancel(request_id)).to eq api_response
    end
  end

  describe "#final_copy" do
    it "fetches a final copy of the signature request" do
      client.should_receive(:get)
        .with('/signature_request/final_copy/request_id')
      sr_proxy.final_copy(request_id)
    end

    it "returns the response" do
      client.stub(:get).and_return(api_response)
      expect(sr_proxy.final_copy(request_id)).to eq api_response
    end
  end
end
