require 'integration/helper'

describe HelloSign do
  context "when creating a team" do
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

  context "when fetching information about a team" do
    before do
      stub_get_with_auth('/team')
      HelloSign.team.show
    end

    it "fetches the team information from the HelloSign API" do
      expect(a_get_with_auth('/team')).to have_been_made
    end
  end
end
