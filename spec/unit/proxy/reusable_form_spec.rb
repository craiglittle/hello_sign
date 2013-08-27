require 'helper'
require 'hello_sign/proxy/reusable_form'

describe HelloSign::Proxy::ReusableForm do
  let(:client)        { double('client') }
  let(:api_response)  { double('API response') }
  let(:form_id)       { 'form_id' }
  let(:email_address) { 'bob@example.com' }

  subject(:rf_proxy)  { HelloSign::Proxy::ReusableForm.new(client, form_id) }

  before do
    allow(client).to receive(:get).and_return(api_response)
    allow(client).to receive(:post).and_return(api_response)
  end

  describe "#list" do
    before { @response = rf_proxy.list(page: 10) }

    it "sends a request to fetch the list of reusable forms" do
      expect(client).to(
        have_received(:get).with('/reusable_form/list', params: {page: 10})
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#show" do
    before { @response = rf_proxy.show }

    it "sends a request to fetch the details of a reusable form" do
      expect(client).to have_received(:get).with("/reusable_form/#{form_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#grant_access" do
    before { @response = rf_proxy.grant_access(email_address: email_address) }

    it "sends a request to grant access" do
      expect(client).to(
        have_received(:post).with(
          "/reusable_form/add_user/#{form_id}",
          body: {email_address: email_address}
        )
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#revoke_access" do
    before { @response = rf_proxy.revoke_access(email_address: email_address) }

    it "sends a request to revoke access" do
      expect(client).to(
        have_received(:post).with(
          "/reusable_form/remove_user/#{form_id}",
          body: {email_address: email_address}
        )
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
