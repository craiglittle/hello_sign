require 'helper'
require 'hello_sign/proxy/unclaimed_draft'

describe HelloSign::Proxy::UnclaimedDraft do
  let(:client)       { double('client') }
  let(:api_response) { double('API response') }
  subject(:ud_proxy) { HelloSign::Proxy::UnclaimedDraft.new(client) }

  describe "#create" do
    let(:formatted_request_body) { double('formatted request body') }
    let(:draft_parameters)       { double('draft parameters') }

    before do
      ud_proxy.draft_parameters = draft_parameters
      draft_parameters.stub(:formatted).and_return(formatted_request_body)
      draft_parameters.should_receive(:foo=).with('bar')
      client.should_receive(:post)
        .with('/unclaimed_draft/create', body: formatted_request_body)
        .and_return(api_response)
    end

    it "sends a unclaimed draft creation request and returns the result" do
      expect(ud_proxy.create { |params| params.foo = 'bar' }).to eq api_response
    end
  end
end
