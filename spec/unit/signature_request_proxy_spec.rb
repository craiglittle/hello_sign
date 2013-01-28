require 'helper'
require 'hello_sign/signature_request_proxy'

describe HelloSign::SignatureRequestProxy do
  let(:client)       { double('client') }
  let(:request_id)   { 'request_id' }
  let(:api_response) { double('API response') }
  subject(:sr_proxy) { HelloSign::SignatureRequestProxy.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(sr_proxy.client).to be client
    end
  end

  describe "#send" do
    let(:formatted_request_body) { double('formatted request body') }
    let(:request_parameters)     { double('request parameters') }

    before do
      sr_proxy.request_parameters = request_parameters
      request_parameters.stub(:formatted).and_return(formatted_request_body)
      request_parameters.should_receive(:foo=).with('bar')
      client.should_receive(:post)
        .with('/signature_request/send', :body => formatted_request_body)
        .and_return(api_response)
    end

    it "sends a signature request creation request and returns the result" do
      expect(sr_proxy.send { |params| params.foo = 'bar' }).to eq api_response
    end
  end

  describe "#status" do
    before { client.should_receive(:get).with('/signature_request/request_id').and_return(api_response) }

    it "fetches the signature request status and returns the result" do
      expect(sr_proxy.status(request_id)).to eq api_response
    end
  end

  describe "#list" do
    context "when called without options" do
      before { client.should_receive(:get).with('/signature_request/list', :params => {:page => 1}).and_return(api_response) }

      it "fetches the first page of signature requests and returns the result" do
        expect(sr_proxy.list).to eq api_response
      end
    end

    context "when called with a page number" do
      before { client.should_receive(:get).with('/signature_request/list', :params => {:page => 10}).and_return(api_response) }

      it "fetches a list of signature requests for the passed page number and returns the result" do
        expect(sr_proxy.list(:page => 10)).to eq api_response
      end
    end
  end

  describe "#remind" do
    let(:email) { 'john@johnson.com' }

    before { client.stub(:post).and_return(api_response) }

    context "when called with the proper parameters" do
      it "sends a signature request reminder to the email address" do
        client.should_receive(:post).with('/signature_request/remind/request_id', :body => {:email_address => email})
        sr_proxy.remind(request_id, :email => email)
      end

      it "returns the API response" do
        expect(sr_proxy.remind(request_id, :email => email)).to eq api_response
      end
    end

    context "when called without proper parameters" do
      it "raises an exception" do
        expect { sr_proxy.remind(request_id) }.to raise_error
      end
    end
  end

  describe "#cancel" do
    before { client.stub(:post).and_return(api_response) }

    it "sends a signature request cancellation" do
      client.should_receive(:post).with('/signature_request/cancel/request_id')
      sr_proxy.cancel(request_id)
    end

    it "returns the API response" do
      expect(sr_proxy.cancel(request_id)).to eq api_response
    end
  end

  describe "#final_copy" do
    before { client.stub(:get).and_return(api_response) }

    it "sends a request to fetch a final copy of the signature request" do
      client.should_receive(:get).with('/signature_request/final_copy/request_id')
      sr_proxy.final_copy(request_id)
    end

    it "returns the API response" do
      expect(sr_proxy.final_copy(request_id)).to eq api_response
    end
  end
end
