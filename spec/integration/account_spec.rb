require File.expand_path('../spec_helper', __FILE__)
require File.expand_path('../../../lib/hello_sign', __FILE__)

describe HelloSign do
  it "creates a new account" do
    account = HelloSign.account.create(:email => 'david@bowman.com', :password => 'foobar')

    a_request(:post, 'https://api.hellosign.com/v3/account/create')
      .with(:body => {:email => 'david@bowman.com', :password => 'foobar'})
      .should have_been_made.once
  end
end
