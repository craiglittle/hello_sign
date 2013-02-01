require 'hello_sign/version'
require 'hello_sign/client'
require 'hello_sign/proxy'

module HelloSign
  class << self
    attr_accessor :email, :password

    def account
      HelloSign::Proxy::Account.new(client)
    end

    def signature_request
      HelloSign::Proxy::SignatureRequest.new(client)
    end

    def reusable_form
      HelloSign::Proxy::ReusableForm.new(client)
    end

    def team
      HelloSign::Proxy::Team.new(client)
    end

    def unclaimed_draft
      HelloSign::Proxy::UnclaimedDraft.new(client)
    end

    def client
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

  end
end
