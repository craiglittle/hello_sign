require 'helper'
require 'hello_sign/proxy/team'

describe HelloSign::Proxy::Team do
  let(:client)         { double('client') }
  let(:api_response)   { double('API response') }
  subject(:team_proxy) { HelloSign::Proxy::Team.new(client) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  its(:client) { should eq client }

  describe "#create" do

    let(:name) { 'The Browncoats' }

    it "sends a request to create a team" do
      client.should_receive(:post).with('/team/create', :body => {:name => name})
      team_proxy.create(:name => name)
    end

    it "returns the API response" do
      expect(team_proxy.create(:name => name)).to eq api_response
    end

  end

  describe "#show" do

    it "sends a request to fetch the team information" do
      client.should_receive(:get).with('/team')
      team_proxy.show
    end

    it "returns the API response" do
      expect(team_proxy.show).to eq api_response
    end

  end

  describe "#update" do

    let(:new_name) { 'The Bluecoats' }

    it "sends a request to update the team information" do
      client.should_receive(:post).with('/team', :body => {:name => new_name})
      team_proxy.update(:name => new_name)
    end

    it "returns the API response" do
      expect(team_proxy.update(:name => new_name)).to eq api_response
    end

  end

  describe "#destroy" do

    it "sends a request to destroy the team" do
      client.should_receive(:post).with('/team/destroy')
      team_proxy.destroy
    end

    it "returns the API response" do
      expect(team_proxy.destroy).to eq api_response
    end

  end

  describe "#add_member" do

    let(:email_address) { 'john@johnson.com' }

    it "sends a request to add the member to the team" do
      client.should_receive(:post).with('/team/add_member', :body => {:email_address => email_address})
      team_proxy.add_member(:email_address => email_address)
    end

    it "returns the API response" do
      expect(team_proxy.add_member(:email_address => email_address)).to eq api_response
    end

  end

  describe "#remove_member" do

    let(:email_address) { 'john@johnson.com' }

    it "sends a request to remove the member from the team" do
      client.should_receive(:post).with('/team/remove_member', :body => {:email_address => email_address})
      team_proxy.remove_member(:email_address => email_address)
    end

    it "returns the API response" do
      expect(team_proxy.remove_member(:email_address => email_address)).to eq api_response
    end

  end
end
