module HelloSign
  class Error < StandardError
    attr_reader :message, :status_code

    def self.from_error_name(error_name)
      case error_name
      when 'bad_request'
        BadRequest
      when 'unauthorized'
        Unauthorized
      when 'forbidden'
        Forbidden
      when 'not_found'
        NotFound
      when 'unknown'
        Unknown
      when 'team_invite_failed'
        TeamInviteFailed
      when 'invalid_recipient'
        InvalidRecipient
      when 'convert_failed'
        ConvertFailed
      when 'signature_request_cancel_failed'
        SignatureRequestCancelFailed
      else
        Error
      end
    end

    def initialize(message = nil, status_code = nil)
      @message, @status_code = message, status_code
    end

    def to_s
      status_code ? message_with_status_code : message
    end

    private

    def message_with_status_code
      "[Status code: #{status_code}] #{message}"
    end

    [
      :BadRequest,
      :Unauthorized,
      :Forbidden,
      :NotFound,
      :Unknown,
      :TeamInviteFailed,
      :InvalidRecipient,
      :ConvertFailed,
      :SignatureRequestCancelFailed
    ].each do |error_name|
      const_set(error_name, Class.new(HelloSign::Error))
    end
  end
end
