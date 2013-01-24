require 'helper'
require 'hello_sign/signature_request_proxy'

describe HelloSign::SignatureRequestProxy do
  let(:client)       { double('client') }
  subject(:sr_proxy) { HelloSign::SignatureRequestProxy.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(sr_proxy.client).to be client
    end
  end

  describe "#create" do
    let(:formatted_request_body) { stub }
    let(:create_response)        { stub }
    let(:raw_parameters)         { Proc.new { |params| params.foo = 'bar' } }

    before do
      HelloSign::SignatureRequestParameters.stub(:new).and_return(request_parameters = mock)
      request_parameters.stub(:formatted).and_return(formatted_request_body)
      request_parameters.should_receive(:foo=).with('bar')
      client.should_receive(:post)
        .with('/signature_request/send', :body => formatted_request_body)
        .and_return(create_response)
    end

    it "sends a signature request creation request and returns the result" do
      expect(sr_proxy.create(raw_parameters)).to eq create_response
    end
  end
end
