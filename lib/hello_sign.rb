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
        signature_request_proxy.status(request_id)
      else
        signature_request_proxy.create(parameters)
      end
    end

    def signature_requests(options = {})
      options = {:page => 1}.merge!(options)
      signature_request_proxy.list(options)
    end

    def client
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

    private

    def signature_request_proxy
      SignatureRequestProxy.new(client)
    end

  end
end
