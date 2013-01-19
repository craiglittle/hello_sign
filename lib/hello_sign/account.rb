require 'hello_sign/client'

module HelloSign
  class Account
    attr_reader :email, :password

    class << self

      def create(credentials)
        email    = credentials.fetch(:email)
        password = credentials.fetch(:password)

        client.post('/v3/account/create', {:email_address => email, :password => password})

        new(email, password)
      end

      private

      def client
        HelloSign.client
      end

    end

    def initialize(email, password)
      @email    = email
      @password = password
    end

  end
end
