require 'hello_sign/version'
require 'hello_sign/client'
require 'hello_sign/account_proxy'

module HelloSign
  class << self
    attr_accessor :email, :password

    def account
      AccountProxy.new
    end

    def client
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

  end
end
