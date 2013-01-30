require 'helper'
require 'hello_sign/team_proxy'

describe HelloSign::TeamProxy do
  let(:client)         { double('client') }
  let(:api_response)   { double('API response') }
  subject(:team_proxy) { HelloSign::TeamProxy.new(client) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  describe "#client" do
    it "returns the client" do
      expect(team_proxy.client).to be client
    end
  end

  describe "#create" do
    let(:name) { 'The Browncoats' }

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

    it "sends a team update request" do
      client.should_receive(:post).with('/team', :body => {:name => new_name})
      team_proxy.update(:name => new_name)
    end

    it "returns the API response" do
      expect(team_proxy.update(:name => new_name)).to eq api_response
    end
  end

  describe "#destroy" do
    it "sends a team destroy request" do
      client.should_receive(:post).with('/team/destroy')
      team_proxy.destroy
    end

    it "returns the API response" do
      expect(team_proxy.destroy).to eq api_response
    end
  end

  describe "#add_member" do
    let(:email)      { 'john@johnson.com' }
    let(:account_id) { '15' }

    context "when called with an email address" do
      it "adds the user with the email address to the team" do
        client.should_receive(:post).with('/team/add_member', :body => {:email_address => email})
        team_proxy.add_member(:email => email)
      end

      it "returns the API response" do
        expect(team_proxy.add_member(:email => email)).to eq api_response
      end
    end

    context "when called with an account ID" do
      it "adds the user with the account ID to the team" do
        client.should_receive(:post).with('/team/add_member', :body => {:account_id => account_id})
        team_proxy.add_member(:account_id => account_id)
      end

      it "returns the API response" do
        expect(team_proxy.add_member(:account_id => account_id)).to eq api_response
      end
    end

    context "when called without proper parameters" do
      it "raises an argument error exception" do
        expect { team_proxy.add_member }.to raise_error ArgumentError
      end
    end
  end

  describe "#remove_member" do
    let(:email)      { 'john@johnson.com' }
    let(:account_id) { '15' }

    context "when called with an email address" do
      it "removes the user with the email address from the team" do
        client.should_receive(:post).with('/team/remove_member', :body => {:email_address => email})
        team_proxy.remove_member(:email => email)
      end

      it "returns the API response" do
        expect(team_proxy.remove_member(:email => email)).to eq api_response
      end
    end

    context "when called with an account ID" do
      it "removes the user with the account ID from the team" do
        client.should_receive(:post).with('/team/remove_member', :body => {:account_id => account_id})
        team_proxy.remove_member(:account_id => account_id)
      end

      it "returns the API response" do
        expect(team_proxy.remove_member(:account_id => account_id)).to eq api_response
      end
    end

    context "when called without proper parameters" do
      it "raises an argument error exception" do
        expect { team_proxy.remove_member }.to raise_error ArgumentError
      end
    end
  end
end
