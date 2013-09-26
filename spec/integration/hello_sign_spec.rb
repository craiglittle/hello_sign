require 'integration/helper'
require 'json'

describe HelloSign do
  context "when returning a response with a body" do
    let(:response) { HelloSign.client.get('/json') }

    before do
      stub_get_with_auth('/json')
        .to_return(
          headers: {'Content-Type' => 'application/json'},
          body:    {account_id: 1}.to_json
        )
    end

    it "returns a HelloSign::Response object" do
      expect(response).to be_a HelloSign::Response
    end

    it "is accessible by indexing" do
      expect(response[:account_id]).to eq 1
    end

    it "is accessible by method calls" do
      expect(response.account_id).to eq 1
    end
  end

  describe "#get" do
    before { stub_get_with_auth('/resource') }

    example do
      HelloSign.client.get('/resource')
      expect(a_get_with_auth('/resource')).to have_been_made
    end

    example do
      HelloSign.client.get('/resource')
      headers = {'User-Agent' => "hello_sign gem v#{HelloSign::VERSION}"}
      expect(a_get_with_auth('/resource').with(headers: headers)).to have_been_made
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
