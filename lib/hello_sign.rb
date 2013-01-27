require 'hello_sign/version'
require 'hello_sign/client'
require 'hello_sign/account_proxy'
require 'hello_sign/signature_request_proxy'

module HelloSign
  class << self
    attr_accessor :email, :password

    def account
      AccountProxy.new(client)
    end

    def signature_request(request_id = nil, &parameters)
      if request_id
        SignatureRequestProxy.new(client).status(request_id)
      else
        SignatureRequestProxy.new(client).create(parameters)
      end
    end

    def client
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

  end
end
