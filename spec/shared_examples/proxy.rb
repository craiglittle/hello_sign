shared_examples_for 'a proxy' do
  let(:proxy)        { double('proxy') }

  describe "#account" do
    it "returns an account proxy" do
      HelloSign::Proxy::Account.should_receive(:new).with(client).and_return(proxy)
      expect(client.account).to eq proxy
    end
  end

  describe "#signature_request" do
    it "returns a signature request proxy" do
      HelloSign::Proxy::SignatureRequest.should_receive(:new).with(client, nil).and_return(proxy)
      expect(client.signature_request).to eq proxy
    end

    it "passes on an optional signature request ID" do
      HelloSign::Proxy::SignatureRequest.should_receive(:new).with(client, 'signature_request_id')
      client.signature_request('signature_request_id')
    end
  end

  describe "#reusable_form" do
    it "returns a reusable form proxy" do
      HelloSign::Proxy::ReusableForm.should_receive(:new).with(client, nil).and_return(proxy)
      expect(client.reusable_form).to eq proxy
    end

    it "passes on an optional reusable form ID" do
      HelloSign::Proxy::ReusableForm.should_receive(:new).with(client, 'reusable_form_id')
      client.reusable_form('reusable_form_id')
    end
  end

  describe "#team" do
    it "returns a team proxy" do
      HelloSign::Proxy::Team.should_receive(:new).with(client).and_return(proxy)
      expect(client.team).to eq proxy
    end
  end

  describe "#unclaimed_draft" do
    it "returns an unclaimed draft proxy" do
      HelloSign::Proxy::UnclaimedDraft.should_receive(:new).with(client).and_return(proxy)
      expect(client.unclaimed_draft).to eq proxy
    end
  end
end
