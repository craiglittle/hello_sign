require 'hello_sign/middleware/raise_error'
require 'hello_sign/client'
require 'hello_sign/version'

require 'forwardable'

module HelloSign
  class << self
    extend Forwardable

    attr_accessor :email_address, :password

    delegate [:account, :signature_request, :reusable_form, :team, :unclaimed_draft] => :client

    def client
      @client = client_source.new(email_address, password) unless credentials_match?
      @client
    end

    def configure
      yield self
    end

    private

    def credentials_match?
      @client && [@client.email_address, @client.password].hash == [email_address, password].hash
    end

    def client_source
      @client_source || HelloSign::Client
    end

    Faraday.register_middleware :response, :raise_error => HelloSign::Middleware::RaiseError

  end
end
