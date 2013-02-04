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
      @client ||= Client.new(email, password)
    end

    def configure
      yield(self)
    end

  end
end
