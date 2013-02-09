require 'helper'
require 'hello_sign/client'
require 'shared_examples/proxy'

describe HelloSign::Client do
  subject(:hs_client) { HelloSign::Client.new('david@bowman.com', 'space') }

  its(:email_address) { should eq 'david@bowman.com' }
  its(:password)      { should eq 'space' }

  it_behaves_like 'a proxy' do
    let(:client) { hs_client }
  end

  context "when a hash is passed to the constructor" do
    let(:hs_client) { HelloSign::Client.new(:email_address => 'david@bowman.com', :password => 'space') }

    it "initializes a new client" do
      expect(hs_client.email_address).to eq 'david@bowman.com'
      expect(hs_client.password).to eq 'space'
    end

    it "raises an exception if an email address is not provided" do
      expect { HelloSign::Client.new(:password => 'space') }.to raise_error ArgumentError
    end

    it "raises an exception if a password is not provided" do
      expect { HelloSign::Client.new(:email_address => 'david@bowman.com') }.to raise_error ArgumentError
    end
  end
end
