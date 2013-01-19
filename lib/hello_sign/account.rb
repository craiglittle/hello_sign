require 'hello_sign/client'

module HelloSign
  class Account
    attr_reader :email, :password

    def initialize(email, password)
      @email    = email
      @password = password
    end

  end
end
