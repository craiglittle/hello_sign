require 'hello_sign/client'

module HelloSign
  module Proxy
    class Settings
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def show
        client.get('/account')
      end

      def update(params = {})
        client.post('/account', body: params)
      end

    end
  end
end
