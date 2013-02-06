require 'integration/helper'

describe HelloSign do
  context "when getting a list of reusable forms" do
    before do
      stub_get_with_auth('/reusable_form/list')
      HelloSign.reusable_form.list
    end

    it "fetches a list of reusable forms from the HelloSign API" do
      expect(a_get_with_auth('/reusable_form/list')).to have_been_made
    end
  end

  context "when fetching information about a reusable form" do
    before do
      stub_get_with_auth('/reusable_form/form_id')
      HelloSign.reusable_form.show('form_id')
    end

    it "fetches the reusable form information from the HelloSign API" do
      expect(a_get_with_auth('/reusable_form/form_id')).to have_been_made
    end
  end

  context "when giving a user access to a reusable form" do
    before do
      stub_post_with_auth('/reusable_form/add_user/form_id')
      HelloSign.reusable_form.grant_access('form_id', :email_address => 'john@johnson.com')
    end

    it "sends a request to grant form access to the HelloSign API" do
      expect(a_post_with_auth('/reusable_form/add_user/form_id')
        .with(:email_address => 'john@johnson.com')
      ).to have_been_made
    end
  end

  context "when taking away a user's access to a reusable form" do
    before do
      stub_post_with_auth('/reusable_form/remove_user/form_id')
      HelloSign.reusable_form.revoke_access('form_id', :email_address => 'john@johnson.com')
    end

    it "sends a request to grant form access to the HelloSign API" do
      expect(a_post_with_auth('/reusable_form/remove_user/form_id')
        .with(:email_address => 'john@johnson.com')
      ).to have_been_made
    end
  end
end
