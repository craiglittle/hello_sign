module HelloSign
  class Error < StandardError
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
