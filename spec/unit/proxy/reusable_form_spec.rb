require 'helper'
require 'hello_sign/proxy/reusable_form'

describe HelloSign::Proxy::ReusableForm do
  let(:client)        { double('client') }
  let(:api_response)  { double('API response') }
  let(:form_id)       { 'form_id' }
  let(:email_address) { 'bob@example.com' }
  subject(:rf_proxy)  { HelloSign::Proxy::ReusableForm.new(client, form_id) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  its(:client)  { should eq client }
  its(:form_id) { should eq form_id }

  describe "#list" do
    it "sends a request to fetch the list of reusable forms" do
      client.should_receive(:get).with('/reusable_form/list', params: {page: 10})
      rf_proxy.list(page: 10)
    end

    it "returns the API response" do
      expect(rf_proxy.list).to eq api_response
    end
  end

  describe "#show" do
    it "sends a request to fetch the details of a reusable form" do
      client.should_receive(:get).with("/reusable_form/#{form_id}")
      rf_proxy.show
    end

    it "returns the API response" do
      expect(rf_proxy.show).to eq api_response
    end
  end

  describe "#grant_access" do
    it "sends a request to grant access" do
      client.should_receive(:post).with("/reusable_form/add_user/#{form_id}", body: {email_address: email_address})
      rf_proxy.grant_access(email_address: email_address)
    end

    it "returns the API response" do
      expect(rf_proxy.grant_access(:email => email_address)).to eq api_response
    end
  end

  describe "#revoke_access" do
    it "sends a request to revoke access" do
      client.should_receive(:post).with("/reusable_form/remove_user/#{form_id}", body: {email_address: email_address})
      rf_proxy.revoke_access(email_address: email_address)
    end

    it "returns the API response" do
      expect(rf_proxy.revoke_access(email_address: email_address)).to eq api_response
    end
  end
end
