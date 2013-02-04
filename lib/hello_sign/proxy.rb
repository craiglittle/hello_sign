require 'hello_sign/proxy/account'
require 'hello_sign/proxy/signature_request'
require 'hello_sign/proxy/reusable_form'
require 'hello_sign/proxy/team'
require 'hello_sign/proxy/unclaimed_draft'

module HelloSign
  module Proxy
    attr_writer :account_proxy_source, :signature_request_proxy_source,
      :reusable_form_proxy_source, :team_proxy_source,
      :unclaimed_draft_proxy_source

    def account
      account_proxy_source.new(self)
    end

    def signature_request
      signature_request_proxy_source.new(self)
    end

    def reusable_form
      reusable_form_proxy_source.new(self)
    end

    def team
      team_proxy_source.new(self)
    end

    def unclaimed_draft
      unclaimed_draft_proxy_source.new(self)
    end

    private

    def account_proxy_source
      @account_proxy_source || HelloSign::Proxy::Account
    end

    def signature_request_proxy_source
      @signature_request_proxy_source || HelloSign::Proxy::SignatureRequest
    end

    def reusable_form_proxy_source
      @reusable_form_proxy_source || HelloSign::Proxy::ReusableForm
    end

    def team_proxy_source
      @team_proxy_source || HelloSign::Proxy::Team
    end

    def unclaimed_draft_proxy_source
      @unclaimed_draft_proxy_source || HelloSign::Proxy::UnclaimedDraft
    end

  end
end
