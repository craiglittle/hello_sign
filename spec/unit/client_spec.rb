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

  it "can be initialized with a hash" do
    client = HelloSign::Client.new(:email_address => 'david@bowman.com', :password => 'space')
    expect(client.email_address).to eq 'david@bowman.com'
    expect(client.password).to eq 'space'
  end
end
