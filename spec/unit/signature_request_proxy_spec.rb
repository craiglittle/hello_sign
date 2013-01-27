require 'helper'
require 'hello_sign/signature_request_proxy'

describe HelloSign::SignatureRequestProxy do
  let(:client)       { mock }
  let(:api_response) { stub }
  subject(:sr_proxy) { HelloSign::SignatureRequestProxy.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(sr_proxy.client).to be client
    end
  end

  describe "#create" do
    let(:formatted_request_body) { stub }
    let(:raw_parameters)         { Proc.new { |params| params.foo = 'bar' } }
    let(:request_parameters)     { mock }

    before do
      sr_proxy.request_parameters = request_parameters
      request_parameters.stub(:formatted).and_return(formatted_request_body)
      request_parameters.should_receive(:foo=).with('bar')
      client.should_receive(:post)
        .with('/signature_request/send', :body => formatted_request_body)
        .and_return(api_response)
    end

    it "sends a signature request creation request and returns the result" do
      expect(sr_proxy.create(raw_parameters)).to eq api_response
    end
  end

  describe "#status" do
    let(:request_id) { 'request_id' }

    before do
      client.should_receive(:get).with('/signature_request/request_id').and_return(api_response)
    end

    it "fetches the signature request status and returns the result" do
      expect(sr_proxy.status(request_id)).to eq api_response
    end
  end
end
