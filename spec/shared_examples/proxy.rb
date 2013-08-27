shared_examples_for 'a proxy' do
  let(:proxy)        { double('proxy') }

  describe "#account" do
    before do
      allow(HelloSign::Proxy::Account).to(
        receive(:new).with(client).and_return(proxy)
      )
    end

    it "returns an account proxy" do
      expect(client.account).to eq proxy
    end
  end

  describe "#signature_request" do
    before { allow(HelloSign::Proxy::SignatureRequest).to receive(:new) }

    context "when called without a signature request ID" do
      before do
        allow(HelloSign::Proxy::SignatureRequest).to(
          receive(:new).with(client, nil).and_return(proxy)
        )
      end

      it "returns a signature request proxy" do
        expect(client.signature_request).to eq proxy
      end
    end

    context "when called with a signature request ID" do
      before { client.signature_request('signature_request_id') }

      it "passes on the signature request ID" do
        expect(HelloSign::Proxy::SignatureRequest).to(
          have_received(:new).with(client, 'signature_request_id')
        )
      end
    end
  end

  describe "#reusable_form" do
    before { allow(HelloSign::Proxy::ReusableForm).to receive(:new) }

    context "when called without a reusable form ID" do
      before do
        allow(HelloSign::Proxy::ReusableForm).to(
          receive(:new).with(client, nil).and_return(proxy)
        )
      end

      it "returns a reusable form proxy" do
        expect(client.reusable_form).to eq proxy
      end
    end

    context "when called with a reusable form ID" do
      before { client.reusable_form('reusable_form_id') }

      it "passes on an optional reusable form ID" do
        expect(HelloSign::Proxy::ReusableForm).to(
          have_received(:new).with(client, 'reusable_form_id')
        )
      end
    end
  end

  describe "#team" do
    before do
      allow(HelloSign::Proxy::Team).to(
        receive(:new).with(client).and_return(proxy)
      )
    end

    it "returns a team proxy" do
      expect(client.team).to eq proxy
    end
  end

  describe "#unclaimed_draft" do
    before do
      allow(HelloSign::Proxy::UnclaimedDraft).to(
        receive(:new).with(client).and_return(proxy)
      )
    end

    it "returns an unclaimed draft proxy" do
      expect(client.unclaimed_draft).to eq proxy
    end
  end
end
