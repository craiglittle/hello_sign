require 'hello_sign/account'

module HelloSign
  class AccountProxy
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(credentials)
      email    = credentials.fetch(:email)
      password = credentials.fetch(:password)

      create_account(email, password)

      true
    end

    private

    def create_account(email, password)
      client.post('/v3/account/create', :body => {:email_address => email, :password => password})
    end

  end
end
