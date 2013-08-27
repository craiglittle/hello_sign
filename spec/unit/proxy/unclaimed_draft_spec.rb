require 'helper'
require 'hello_sign/proxy/unclaimed_draft'

describe HelloSign::Proxy::UnclaimedDraft do
  let(:client)       { double('client') }
  let(:api_response) { double('API response') }

  subject(:ud_proxy) { HelloSign::Proxy::UnclaimedDraft.new(client) }

  before { allow(client).to receive(:post).and_return(api_response) }

  describe "#create" do
    let(:formatted_request_body) { double('formatted request body') }
    let(:draft_parameters)       { double('draft parameters') }

    before do
      allow(HelloSign::Parameters::UnclaimedDraft).to(
        receive(:new).and_return(draft_parameters)
      )
      allow(draft_parameters).to(
        receive(:formatted).and_return(formatted_request_body)
      )
      allow(draft_parameters).to receive(:foo=)

      @response = ud_proxy.create { |params| params.foo = 'bar' }
    end

    it "yields the request parameters to the block" do
      expect(draft_parameters).to have_received(:foo=).with('bar')
    end

    it "sends an unclaimed draft creation request" do
      expect(client).to have_received(:post).with(
        '/unclaimed_draft/create',
        body: formatted_request_body
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end
  end
end
