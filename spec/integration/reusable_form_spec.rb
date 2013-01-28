require 'integration/helper'

describe HelloSign do
  context "when getting a list of reusable forms" do
    before do
      stub_get_with_auth('/reusable_form/list?page=1')
      HelloSign.reusable_form.list
    end

    it "fetches a list of reusable forms from the HelloSign API" do
      expect(a_get_with_auth('/reusable_form/list?page=1')).to have_been_made
    end
  end
end
