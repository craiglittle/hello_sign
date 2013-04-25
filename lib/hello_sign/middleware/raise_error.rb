require 'hello_sign/error'

require 'faraday'

module HelloSign
  module Middleware
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        body = env[:body] or return

        if error = body[:error]
          message = error[:error_msg]
          case error[:error_name]
          when 'bad_request'                     then raise HelloSign::Error::BadRequest, message
          when 'unauthorized'                    then raise HelloSign::Error::Unauthorized, message
          when 'forbidden'                       then raise HelloSign::Error::Forbidden, message
          when 'not_found'                       then raise HelloSign::Error::NotFound, message
          when 'unknown'                         then raise HelloSign::Error::Unknown, message
          when 'team_invite_failed'              then raise HelloSign::Error::TeamInviteFailed, message
          when 'invalid_recipient'               then raise HelloSign::Error::InvalidRecipient, message
          when 'convert_failed'                  then raise HelloSign::Error::ConvertFailed, message
          when 'signature_request_cancel_failed' then raise HelloSign::Error::SignatureRequestCancelFailed, message
          end
        end
      end

    end
  end
end
