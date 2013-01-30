require 'integration/helper'

describe HelloSign do
  context "when returning a response with a body" do
    before { stub_get('/json').to_return(:body => {:account_id => 1}.to_json) }

    it "renders it as JSON" do
      expect(HelloSign.client.get('/json', :auth_not_required => true)).to eq({:account_id => 1})
    end
  end
end
