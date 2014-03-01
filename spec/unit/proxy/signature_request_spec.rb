require 'helper'
require 'hello_sign/proxy/signature_request'

describe HelloSign::Proxy::SignatureRequest do
  let(:client)       { double('client') }
  let(:request_id)   { 'request_id' }
  let(:api_response) { double('API response') }

  subject(:sr_proxy) do
    HelloSign::Proxy::SignatureRequest.new(client, request_id)
  end

  before do
    allow(client).to receive(:get).and_return(api_response)
    allow(client).to receive(:post).and_return(api_response)
  end

  describe "#deliver" do
    let(:formatted_request_body) { double('formatted request body') }
    let(:request_parameters)     { double('request parameters') }

    before do
      allow(request_parameters).to receive(:foo=)
      allow(request_parameters).to(
        receive(:formatted).and_return(formatted_request_body)
      )
      allow(HelloSign::Parameters::SignatureRequest).to(
        receive(:new).and_return(request_parameters)
      )

      @response = sr_proxy.deliver { |params| params.foo = 'bar' }
    end

    it "yields the request parameters to the block" do
      expect(request_parameters).to have_received(:foo=).with('bar')
    end

    it "sends a signature request" do
      expect(client).to have_received(:post).with(
        '/signature_request/send',
        body: formatted_request_body
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end

    context "when a reusable form is specified" do
      before do
        allow(request_parameters).to receive(:reusable_form_id=)
        allow(HelloSign::Parameters::ReusableFormSignatureRequest).to(
          receive(:new).and_return(request_parameters)
        )

        @response = sr_proxy.deliver(form: 'form_id') { }
      end

      it "sets the reusable form ID in the request parameters" do
        expect(request_parameters).to(
          have_received(:reusable_form_id=).with('form_id')
        )
      end

      it "sends a reusable form signature request" do
        expect(client).to have_received(:post).with(
          '/signature_request/send_with_reusable_form',
          body: formatted_request_body
        )
      end

      it "returns the response" do
        expect(@response).to eq api_response
      end
    end
  end

  describe "#create_embedded_request" do
    let(:formatted_request_body) { double('formatted request body') }
    let(:request_parameters)     { double('request parameters') }

    before do
      allow(client).to receive(:client_id).and_return('client_id')
      allow(request_parameters).to receive(:foo=)
      allow(request_parameters).to receive(:client_id=)
      allow(request_parameters).to(
        receive(:formatted).and_return(formatted_request_body)
      )
      allow(HelloSign::Parameters::SignatureRequest).to(
        receive(:new).and_return(request_parameters)
      )

      @response = sr_proxy.create_embedded_request { |p| p.foo = 'bar' }
    end

    it "yields the request parameters to the block" do
      expect(request_parameters).to have_received(:foo=).with('bar')
    end

    it "sets the client ID in the request parameters" do
      expect(request_parameters).to(
        have_received(:client_id=).with('client_id')
      )
    end

    it "sends a signature request" do
      expect(client).to have_received(:post).with(
        '/signature_request/create_embedded',
        body: formatted_request_body
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end

    context "when a reusable form is specified" do
      let(:form_request_parameters) { double('form request parameters') }

      before do
        allow(client).to receive(:client_id).and_return('client_id')

        allow(form_request_parameters).to receive(:client_id=)
        allow(form_request_parameters).to(
          receive(:formatted).and_return(formatted_request_body)
        )
        allow(form_request_parameters).to receive(:reusable_form_id=)

        allow(HelloSign::Parameters::ReusableFormSignatureRequest).to(
          receive(:new).and_return(form_request_parameters)
        )

        @response = sr_proxy.create_embedded_request(form: 'form_id') { }
      end

      it "sets the reusable form ID in the request parameters" do
        expect(form_request_parameters).to(
          have_received(:reusable_form_id=).with('form_id')
        )
      end

      it "sends a reusable form signature request" do
        expect(client).to have_received(:post).with(
          '/signature_request/create_embedded_with_reusable_form',
          body: formatted_request_body
        )
      end

      it "returns the response" do
        expect(@response).to eq api_response
      end
    end
  end

  describe "#status" do
    before { @response = sr_proxy.status }

    it "fetches the signature request status" do
      expect(client).to have_received(:get).with(
        "/signature_request/#{request_id}"
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end
  end

  describe "#list" do
    context "when called without a page number" do
      before { @response = sr_proxy.list }

      it "fetches the first page of signature requests" do
        expect(client).to have_received(:get).with(
          '/signature_request/list',
          params: {page: 1}
        )
      end

      it "returns the response" do
        expect(@response).to eq api_response
      end
    end

    context "when called with a page number" do
      before { @response = sr_proxy.list(page: 10) }

      it "fetches a list of signature requests from the specified page" do
        expect(client).to have_received(:get).with(
          '/signature_request/list',
          params: {page: 10}
        )
      end

      it "returns the response" do
        expect(@response).to eq api_response
      end
    end
  end

  describe "#remind" do
    let(:email) { 'john@johnson.com' }

    before { @response = sr_proxy.remind(email: email) }

    it "sends a signature request reminder" do
      expect(client).to have_received(:post).with(
        "/signature_request/remind/#{request_id}",
        body: {email_address: email}
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end
  end

  describe "#cancel" do
    before { @response = sr_proxy.cancel }

    it "cancels a signature request" do
      expect(client).to have_received(:post).with(
        "/signature_request/cancel/#{request_id}"
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end
  end

  describe "#final_copy" do
    before { @response = sr_proxy.final_copy }

    it "fetches a final copy of the signature request" do
      expect(client).to have_received(:get).with(
        "/signature_request/final_copy/#{request_id}"
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end
  end

  describe "#temporary_signature_url" do
    let(:signature_id) { double('signature_id') }

    before { @response = sr_proxy.temporary_signature_url(signature_id) }

    it "fetches the temporary URL for an embedded request" do
      expect(client).to have_received(:get).with(
        "/embedded/sign_url/#{signature_id}"
      )
    end

    it "returns the response" do
      expect(@response).to eq api_response
    end
  end
end
