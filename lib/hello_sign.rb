require 'hello_sign/version'
require 'hello_sign/client'
require 'hello_sign/account_proxy'
require 'hello_sign/signature_request_proxy'
require 'hello_sign/reusable_form_proxy'
require 'hello_sign/team_proxy'
require 'hello_sign/unclaimed_draft_proxy'

module HelloSign
  class << self
    attr_accessor :email, :password

    def account
      AccountProxy.new(client)
    end

    def signature_request
      SignatureRequestProxy.new(client)
    end

    def reusable_form
      ReusableFormProxy.new(client)
    end

    def team
      TeamProxy.new(client)
    end

    def unclaimed_draft
      UnclaimedDraftProxy.new(client)
    end

    def client
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

  end
end
