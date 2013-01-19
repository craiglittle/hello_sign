require 'hello_sign/account'

module HelloSign
  class AccountProxy

    def create(credentials)
      email    = credentials.fetch(:email)
      password = credentials.fetch(:password)

      create_account(email, password)

      Account.new(email, password)
    end

    private

    def create_account(email, password)
      client.post('/v3/account/create', {:email_address => email, :password => password})
    end

    def client
      HelloSign.client
    end

  end
end
