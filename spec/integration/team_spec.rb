require 'integration/helper'

describe HelloSign do
  context "when creating an account" do
    before do
      stub_post_with_auth('/team/create')
      HelloSign.team.create(:name => 'The Browncoats')
    end

    it "sends a team creation request to the HelloSign API" do
      expect(a_post_with_auth('/team/create')
        .with(:body => {:name => 'The Browncoats'})
      ).to have_been_made
    end
  end
end
