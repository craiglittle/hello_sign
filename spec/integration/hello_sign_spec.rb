require 'integration/helper'
require 'json'

describe HelloSign do
  context "when returning a response with a body" do
    before { stub_get_with_auth('/json').to_return(body: {account_id: 1}.to_json) }

    it "parses the body into a hash with symbols as keys" do
      expect(HelloSign.client.get('/json')).to eq({account_id: 1})
    end
  end

  describe "#get" do
    before { stub_get_with_auth('/resource') }

    example do
      HelloSign.client.get('/resource')
      expect(a_get_with_auth('/resource')).to have_been_made
    end
  end

  describe "#post" do
    before { stub_post_with_auth('/resource') }

    example do
      HelloSign.client.post('/resource')
      expect(a_post_with_auth('/resource')).to have_been_made
    end
  end
end
