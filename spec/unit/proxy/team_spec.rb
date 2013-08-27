require 'helper'
require 'hello_sign/proxy/team'

describe HelloSign::Proxy::Team do
  let(:client)         { double('client') }
  let(:api_response)   { double('API response') }

  subject(:team_proxy) { HelloSign::Proxy::Team.new(client) }

  before do
    allow(client).to receive(:get).and_return(api_response)
    allow(client).to receive(:post).and_return(api_response)
  end

  describe "#create" do
    let(:name) { 'The Browncoats' }

    before { @response = team_proxy.create(name: name) }

    it "sends a request to create a team" do
      expect(client).to have_received(:post).with(
        '/team/create',
        body: {name: name}
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#show" do
    before { @response = team_proxy.show }

    it "sends a request to fetch the team information" do
      expect(client).to have_received(:get).with('/team')
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#update" do
    let(:new_name) { 'The Bluecoats' }

    before { @response = team_proxy.update(name: new_name) }

    it "sends a request to update the team information" do
      expect(client).to have_received(:post).with(
        '/team',
        body: {name: new_name}
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#destroy" do
    before { @response = team_proxy.destroy }

    it "sends a request to destroy the team" do
      expect(client).to have_received(:post).with('/team/destroy')
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#add_member" do
    let(:email_address) { 'john@johnson.com' }

    before { @response = team_proxy.add_member(email_address: email_address) }

    it "sends a request to add the member to the team" do
      expect(client).to have_received(:post).with(
        '/team/add_member',
        body: {email_address: email_address}
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#remove_member" do
    let(:email_address) { 'john@johnson.com' }

    before { @response = team_proxy.remove_member(email_address: email_address) }

    it "sends a request to remove the member from the team" do
      expect(client).to have_received(:post).with(
        '/team/remove_member',
        body: {email_address: email_address}
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
