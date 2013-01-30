require 'helper'
require 'hello_sign/team_proxy'

describe HelloSign::TeamProxy do
  let(:client)         { double('client') }
  let(:api_response)   { double('API response') }
  subject(:team_proxy) { HelloSign::TeamProxy.new(client) }

  describe "#client" do
    it "returns the client" do
      expect(team_proxy.client).to be client
    end
  end

  describe "#create" do
    let(:name) { 'The Browncoats' }

    before { client.stub(:post).and_return(api_response) }

    context "when called with the proper parameters" do
      it "sends a team creation request" do
        client.should_receive(:post).with('/team/create', :body => {:name => name})
        team_proxy.create(:name => name)
      end

      it "returns the API response" do
        expect(team_proxy.create(:name => name)).to eq api_response
      end
    end

    context "when called without the proper parameters" do
      it "raises an exception" do
        expect { team_proxy.create }.to raise_error
      end
    end
  end

  describe "#show" do
    before { client.stub(:get).and_return(api_response) }

    it "fetches the team information" do
      client.should_receive(:get).with('/team')
      team_proxy.show
    end

    it "returns the API response" do
      expect(team_proxy.show).to eq api_response
    end
  end

  describe "#update" do
    let(:new_name) { 'The Bluecoats' }

    before { client.stub(:post).and_return(api_response) }

    it "sends a team update request" do
      client.should_receive(:post).with('/team', :body => {:name => new_name})
      team_proxy.update(:name => new_name)
    end

    it "returns the API response" do
      expect(team_proxy.update(:name => new_name)).to eq api_response
    end
  end
end
