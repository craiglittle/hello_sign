require 'helper'
require 'hello_sign/client'
require 'shared_examples/proxy'

describe HelloSign::Client do
  subject(:hs_client) { HelloSign::Client.new('david@bowman.com', 'space') }

  its(:email)    { should eq 'david@bowman.com' }
  its(:password) { should eq 'space' }

  it_behaves_like 'a proxy' do
    let(:client) { hs_client }
  end
end
