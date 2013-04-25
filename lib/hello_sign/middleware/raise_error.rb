require 'hello_sign/error'

require 'faraday'

module HelloSign
  module Middleware
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        body = env[:body] or return

        error = body[:error] and begin
          exception = begin
            case error[:error_name]
            when 'bad_request'
              HelloSign::Error::BadRequest
            when 'unauthorized'
              HelloSign::Error::Unauthorized
            when 'forbidden'
              HelloSign::Error::Forbidden
            when 'not_found'
              HelloSign::Error::NotFound
            when 'unknown'
              HelloSign::Error::Unknown
            when 'team_invite_failed'
              HelloSign::Error::TeamInviteFailed
            when 'invalid_recipient'
              HelloSign::Error::InvalidRecipient
            when 'convert_failed'
              HelloSign::Error::ConvertFailed
            when 'signature_request_cancel_failed'
              HelloSign::Error::SignatureRequestCancelFailed
            else
              HelloSign::Error
            end
          end

          message     = error[:error_msg]
          status_code = env[:response][:status]

          raise exception.new(message, status_code)
        end
      end

    end
  end
end
