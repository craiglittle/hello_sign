require 'hello_sign/proxy/account'
require 'hello_sign/proxy/signature_request'
require 'hello_sign/proxy/reusable_form'
require 'hello_sign/proxy/team'
require 'hello_sign/proxy/unclaimed_draft'

module HelloSign
  module Proxy

    def account
      HelloSign::Proxy::Account.new(self)
    end

    def signature_request(request_id = nil)
      HelloSign::Proxy::SignatureRequest.new(self, request_id)
    end

    def reusable_form(form_id = nil)
      HelloSign::Proxy::ReusableForm.new(self, form_id)
    end

    def team
      HelloSign::Proxy::Team.new(self)
    end

    def unclaimed_draft
      HelloSign::Proxy::UnclaimedDraft.new(self)
    end

  end
end
