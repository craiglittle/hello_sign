require 'hello_sign/middleware/raise_error'
require 'hello_sign/middleware/parse_json'
require 'hello_sign/client'
require 'hello_sign/version'
require 'forwardable'

module HelloSign
  class << self
    extend Forwardable

    attr_accessor :email_address, :password, :client_id

    delegate [
      :account,
      :signature_request,
      :reusable_form,
      :team,
      :unclaimed_draft
    ] => :client

    def client
      unless credentials_match?
        @client = HelloSign::Client.new(email_address, password, client_id)
      end

      @client
    end

    def configure
      yield self
    end

    private

    def credentials_match?
      instance_variable_defined?(:@client) &&
        client_credentials.hash == provided_credentials.hash
    end

    def client_credentials
      [@client.email_address, @client.password, @client.client_id]
    end

    def provided_credentials
      [email_address, password, client_id]
    end

    Faraday.register_middleware(
      :response,
      raise_error: HelloSign::Middleware::RaiseError
    )
    Faraday.register_middleware(
      :response,
      json: HelloSign::Middleware::ParseJson
    )

  end
end
