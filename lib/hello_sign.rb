require 'hello_sign/version'
require 'hello_sign/client'
require 'hello_sign/account'

module HelloSign
  class << self
    attr_accessor :email, :password

    def account
      Account
    end

    def client
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

  end
end
