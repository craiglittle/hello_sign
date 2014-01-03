require 'hello_sign/proxy/object'

module HelloSign
  module Proxy
    class Settings < Object

      def show
        @client.get('/account')
      end

      def update(params = {})
        @client.post('/account', body: params)
      end

    end
  end
end
