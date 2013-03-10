shared_examples_for 'a proxy' do
  let(:proxy_source) { double('proxy source') }
  let(:proxy)        { double('proxy') }

  describe "#account" do
    before { client.account_proxy_source = proxy_source }

    it "returns an account proxy" do
      proxy_source.should_receive(:new).with(client).and_return(proxy)
      expect(client.account).to eq proxy
    end
  end

  describe "#signature_request" do
    before { client.signature_request_proxy_source = proxy_source }

    it "returns a signature request proxy" do
      proxy_source.should_receive(:new).with(client, nil).and_return(proxy)
      expect(client.signature_request).to eq proxy
    end

    it "passes on an optional signature request ID" do
      proxy_source.should_receive(:new).with(client, 'signature_request_id')
      client.signature_request('signature_request_id')
    end
  end

  describe "#reusable_form" do
    before { client.reusable_form_proxy_source = proxy_source }

    it "returns a reusable form proxy" do
      proxy_source.should_receive(:new).with(client, nil).and_return(proxy)
      expect(client.reusable_form).to eq proxy
    end

    it "passes on an optional reusable form ID" do
      proxy_source.should_receive(:new).with(client, 'reusable_form_id')
      client.reusable_form('reusable_form_id')
    end
  end

  describe "#team" do
    before { client.team_proxy_source = proxy_source }

    it "returns a team proxy" do
      proxy_source.should_receive(:new).with(client).and_return(proxy)
      expect(client.team).to eq proxy
    end
  end

  describe "#unclaimed_draft" do
    before { client.unclaimed_draft_proxy_source = proxy_source }

    it "returns an unclaimed draft proxy" do
      proxy_source.should_receive(:new).with(client).and_return(proxy)
      expect(client.unclaimed_draft).to eq proxy
    end
  end
end
