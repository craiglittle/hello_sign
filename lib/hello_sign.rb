require 'hello_sign/version'
require 'hello_sign/account_proxy'

require 'faraday'

module HelloSign

  def self.account
    AccountProxy.new
  end

end
