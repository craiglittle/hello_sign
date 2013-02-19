require 'hello_sign/error'

require 'faraday'

module HelloSign
  module Middleware
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        body = env[:body] or return

        if error = body[:error]
          case error[:error_name]
          when 'bad_request'                     then raise HelloSign::Error::BadRequest
          when 'unauthorized'                    then raise HelloSign::Error::Unauthorized
          when 'forbidden'                       then raise HelloSign::Error::Forbidden
          when 'not_found'                       then raise HelloSign::Error::NotFound
          when 'unknown'                         then raise HelloSign::Error::Unknown
          when 'team_invite_failed'              then raise HelloSign::Error::TeamInviteFailed
          when 'invalid_recipient'               then raise HelloSign::Error::InvalidRecipient
          when 'convert_failed'                  then raise HelloSign::Error::ConvertFailed
          when 'signature_request_cancel_failed' then raise HelloSign::Error::SignatureRequestCancelFailed
          end
        end
      end

    end
  end
end
