require 'hello_sign/proxy/settings'

module HelloSign
  module Proxy
    class Account
      attr_reader :client
      attr_writer :settings_proxy_source

      def initialize(client)
        @client = client
      end

      def create(params = {})
        client.post('/account/create', body: params, auth_not_required: true)
      end

      def settings
        settings_proxy_source.new(client)
      end

      private

      def settings_proxy_source
        @settings_proxy_source || HelloSign::Proxy::Settings
      end

    end
  end
end
