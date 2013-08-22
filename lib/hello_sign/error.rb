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
