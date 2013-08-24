require 'faraday'
require 'json'

module HelloSign
  module Middleware
    class ParseJson < Faraday::Response::Middleware

      def on_complete(env)
        body = env[:body] or return

        env[:body] = ::JSON.parse(body, symbolize_names: true)
      end

    end
  end
end
