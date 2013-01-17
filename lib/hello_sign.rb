require 'hello_sign/version'

module HelloSign
  def self.account
    AccountProxy.new
  end

  class AccountProxy
    def create(credentials)
    end
  end
end
