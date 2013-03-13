require 'integration/helper'

describe HelloSign do
  context "creating a team" do
    before { stub_post_with_auth('/team/create') }

    example do
      HelloSign.team.create(name: 'The Browncoats')

      expect(a_post_with_auth('/team/create')
        .with(body: {name: 'The Browncoats'}))
        .to have_been_made
    end
  end

  context "fetching team information" do
    before { stub_get_with_auth('/team') }

    example do
      HelloSign.team.show

      expect(a_get_with_auth('/team'))
        .to have_been_made
    end
  end

  context "updating team information" do
    before { stub_post_with_auth('/team') }

    example do
      HelloSign.team.update(name: 'The Bluecoats')

      expect(a_post_with_auth('/team')
        .with(name: 'The Bluecoats'))
        .to have_been_made
    end
  end

  context "destroying a team" do
    before { stub_post_with_auth('/team/destroy') }

    example do
      HelloSign.team.destroy

      expect(a_post_with_auth('/team/destroy'))
        .to have_been_made
    end
  end

  context "adding a member to a team" do
    before { stub_post_with_auth('/team/add_member') }

    example do
      HelloSign.team.add_member(email: 'bob@smith.com')

      expect(a_post_with_auth('/team/add_member')
        .with(email: 'bob@smith.com'))
        .to have_been_made
    end
  end

  context "removing a member from a team" do
    before { stub_post_with_auth('/team/remove_member') }

    example do
      HelloSign.team.remove_member(email: 'bob@smith.com')

      expect(a_post_with_auth('/team/remove_member')
        .with(email: 'bob@smith.com'))
        .to have_been_made
    end
  end
end
