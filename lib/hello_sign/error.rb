module HelloSign
  class Error < StandardError
    attr_reader :message, :status_code

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

    class BadRequest                   < HelloSign::Error; end
    class Unauthorized                 < HelloSign::Error; end
    class Forbidden                    < HelloSign::Error; end
    class NotFound                     < HelloSign::Error; end
    class Unknown                      < HelloSign::Error; end
    class TeamInviteFailed             < HelloSign::Error; end
    class InvalidRecipient             < HelloSign::Error; end
    class ConvertFailed                < HelloSign::Error; end
    class SignatureRequestCancelFailed < HelloSign::Error; end
  end
end
