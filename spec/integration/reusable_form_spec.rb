require 'integration/helper'

describe HelloSign do
  context "when getting a list of reusable forms" do
    before { stub_get_with_auth('/reusable_form/list') }

    it "fetches a list of reusable forms from the HelloSign API" do
      HelloSign.reusable_form.list

      expect(a_get_with_auth('/reusable_form/list')).to have_been_made
    end
  end

  context "when fetching information about a reusable form" do
    before { stub_get_with_auth('/reusable_form/form_id') }

    it "fetches the reusable form information from the HelloSign API" do
      HelloSign.reusable_form('form_id').show

      expect(a_get_with_auth('/reusable_form/form_id')).to have_been_made
    end
  end

  context "when granting user access to a reusable form" do
    before { stub_post_with_auth('/reusable_form/add_user/form_id') }

    it "sends a request to grant form access to the HelloSign API" do
      HelloSign.reusable_form('form_id').grant_access(email_address: 'john@johnson.com')

      expect(a_post_with_auth('/reusable_form/add_user/form_id')
        .with(email_address: 'john@johnson.com')
      ).to have_been_made
    end
  end

  context "when revoking user access to a reusable form" do
    before { stub_post_with_auth('/reusable_form/remove_user/form_id') }

    it "sends a request to grant form access to the HelloSign API" do
      HelloSign.reusable_form('form_id').revoke_access(email_address: 'john@johnson.com')

      expect(a_post_with_auth('/reusable_form/remove_user/form_id')
        .with(email_address: 'john@johnson.com')
      ).to have_been_made
    end
  end
end
