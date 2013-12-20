require 'faraday'
require 'hello_sign/error'

module HelloSign
  module Middleware
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        body = env[:body] and body.is_a?(Hash) or return

        error = body[:error] and begin
          exception   = Error.from_error_name(error[:error_name])
          message     = error[:error_msg]
          status_code = env[:response][:status]

          fail exception.new(message, status_code)
        end
      end

    end
  end
end
