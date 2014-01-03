require 'hello_sign/proxy/object'
require 'hello_sign/proxy/settings'

module HelloSign
  module Proxy
    class Account < Object

      def create(params = {})
        @client.post('/account/create', body: params, auth_not_required: true)
      end

      def settings
        HelloSign::Proxy::Settings.new(@client)
      end

    end
  end
end
