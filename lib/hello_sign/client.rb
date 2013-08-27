require 'hello_sign/proxy'
require 'hello_sign/connection'
require 'forwardable'

module HelloSign
  class Client
    extend Forwardable

    include HelloSign::Proxy

    attr_reader :email_address, :password

    def initialize(email_or_hash, password = nil)
      if email_or_hash.is_a?(Hash)
        @email_address = email_or_hash.fetch(:email_address) { raise ArgumentError }
        @password      = email_or_hash.fetch(:password) { raise ArgumentError }
      else
        @email_address = email_or_hash
        @password      = password
      end
    end

    delegate [:get, :post] => :connection

    private

    def connection
      HelloSign::Connection.new do |connection|
        connection.request :basic_auth, email_address, password
      end
    end

  end
end
