require 'hello_sign/client'
require 'hello_sign/proxy'
require 'hello_sign/version'

require 'forwardable'

module HelloSign
  class << self
    extend Forwardable

    attr_accessor :email, :password

    delegate [:account, :signature_request, :reusable_form, :team,
      :unclaimed_draft] => :client

    def client
      @client = Client.new(email, password) unless credentials_match?
      @client
    end

    def configure
      yield(self)
    end

    private

    def credentials_match?
      @client && [@client.email, @client.password].hash == [email, password].hash
    end

  end
end
